# frozen_string_literal: true

ALLOWED_DOMAIN = 'ALLOWED_DOMAIN'.freeze

describe User do
  let(:domain) { 'domain.com' }

  let(:email) { 'user@' + domain }

  let(:other_email) { 'user@otherdomain.com' }

  describe 'validations' do
    it { should validate_presence_of(:email) }

    it { should validate_uniqueness_of(:email) }

    it { should validate_uniqueness_of(:auth_id) }

    it 'should validate email with the given domain' do
      stub_env_variable(ALLOWED_DOMAIN, domain)
      user = User.new(email: email)
      expect(user.save).to be true
    end

    it 'should validate email with any domain if domain is not provided' do
      user = User.new(email: 'user@foobar.com')
      expect(user.save).to be true
    end

    it 'should throw error if given email is not vaild with the domain' do
      stub_env_variable(ALLOWED_DOMAIN, domain)
      user = User.new(email: other_email)
      expect(user.save).to be false
      expect(user.errors.full_messages).to include('Email must be a valid email id...')
    end
  end

  context 'private methods' do
    describe '#valid_email?' do
      it 'should validate if email is of specified domain' do
        user = User.new
        expect(user.send(:valid_email?, domain, email)).to be true
      end
    end

    describe '#validate_email' do
      it 'should validate email if it belongs to specified domain' do
        stub_env_variable(ALLOWED_DOMAIN, domain)
        user = User.new(email: email)
        expect(user.send(:validate_email)).to be nil
        expect(user.errors.full_messages).to be_empty
      end

      it 'should validate email of any domain if no domain is specified' do
        user = User.new(email: other_email)
        expect(user.send(:validate_email)).to be nil
        expect(user.errors.full_messages).to be_empty
      end

      it 'should throw error if the email is not of specified domain' do
        stub_env_variable(ALLOWED_DOMAIN, domain)
        user = User.new(email: other_email)
        expect(user.send(:validate_email)).to match ['must be a valid email id...']
        expect(user.errors.full_messages).to match ['Email must be a valid email id...']
      end
    end

    describe '#filter_by_passage' do
      it 'should filter users who have given responses to the passage' do
        passage1 = double('Passage', id: 11, user_id: 1)

        response1 = double('Response', id: 1, passage_id: 11)

        user1 = double('User', passages: [passage1], user_id: 1, responses: [response1])

        expect(Response).to receive('where').with(passage_id: 11).and_return([passage1])
        expect(User).to receive(:active_interns).and_return(user1)
        expect(user1).to receive('where').with(id: [1]).and_return(user1)

        user_filter_by_passage = User.filter_by_passage(11, :done)

        expect(user_filter_by_passage).to eq(user1)
      end

      it 'should filter users who have not given responses to the passage' do
        passage1 = double('Passage', id: 11, user_id: 1)

        user2 = double('User', user_id: 2)

        expect(Response).to receive('where').with(passage_id: 11).and_return([passage1])
        allow(User).to receive(:active_interns).and_return(user2)
        allow(user2).to receive_message_chain('where.not').with(id: [1], name: nil).and_return(user2)

        user_filter_by_passage = User.filter_by_passage(11, :incomplete)

        expect(user_filter_by_passage).to eq(user2)
      end
    end
  end
end
