# frozen_string_literal: true

describe ResponsesTracking do
  describe 'validations ' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:passage_id) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:passage) }
  end

  let(:passages) do
    [
      {
        title: 'Climate Change', text: 'climate change passage', commence_time: Time.current, conclude_time: (Time.current + 2.days), duration: '86400'
      },

      {
        title: 'Person', text: 'person passage', commence_time: Time.current, conclude_time: (Time.current + 2.days), duration: '86400'
      },
      {
        title: 'Program', text: 'program passage', commence_time: Time.current, conclude_time: (Time.current + 2.days), duration: '86400'
      },

      {
        title: 'Computer', text: 'computer passage', commence_time: Time.current, conclude_time: (Time.current + 2.days), duration: '0'
      },
      {
        title: 'Human', text: 'human passage', commence_time: Time.current, conclude_time: (Time.current + 2.days), duration: '86400'
      }
    ]
  end

  intern_role_id = Role.intern.id

  let(:users) do
    [
      {
        name: 'Kamal Hasan', role_id: intern_role_id, email: 'kamalhasan@email.com', auth_id: '132271', image_url: 'http://graph.facebook.com/demo1'
      },
      {
        name: 'Vimal Hasan', role_id: intern_role_id, email: 'vimalhasan@email.com', auth_id: '132273', image_url: 'http://graph.facebook.com/demo1'
      },
      {
        name: 'Rajanikanth', role_id: intern_role_id, email: 'rajinikanth@email.com', auth_id: '132272', image_url: 'http://graph.facebook.com/demo2'
      }
    ]
  end

  before(:each) do
    @users = User.create(users)
    @passages = Passage.create(passages)
  end

  after(:each) do
    ResponsesTracking.delete_all
    @users.each(&:delete)
    @passages.each(&:delete)
  end

  describe 'remaining_time' do
    context 'when the candidate has not taken the passage yet' do
      it 'should save the start time of the ongoing response session for the passage' do
        remaining_time = ResponsesTracking.remaining_time(@passages.first.id, @users.first.id)

        expect(remaining_time.round).to eq(86_400)
      end
    end
    context 'when the candidate has started the test and not yet completed' do
      it 'should give remaining time from the time the test started' do
        time = (Time.current - 0.5.day)
        ResponsesTracking.create(passage_id: @passages.first.id, user_id: @users.first.id, created_at: time, updated_at: time)
        expected_remaining_time = ResponsesTracking.remaining_time(@passages.first.id, @users.first.id)

        expect(expected_remaining_time.round).to be(43_200)
      end
      it 'should give remaining time 0 if the duration has ended' do
        time = (Time.current - 1.day)
        ResponsesTracking.create(passage_id: @passages.first.id, user_id: @users.first.id, created_at: time, updated_at: time)
        expected_remaining_time = ResponsesTracking.remaining_time(@passages.first.id, @users.first.id)

        expect(expected_remaining_time.round).to be(0)
      end
      it 'should give remaining time to conclude time if the passage closing time is less than duration' do
        time = (Time.current + 1.98.day)
        passage = @passages.second
        ResponsesTracking.create(passage_id: passage.id, user_id: @users.first.id, created_at: time, updated_at: time)
        expected_remaining_time = ResponsesTracking.remaining_time(passage.id, @users.first.id)

        expect(expected_remaining_time.round).to be(172_800)
      end
      it 'should give remaining time 0 if the response has been submitted' do
        ResponsesTracking.create(passage_id: @passages.fifth.id, user_id: @users.first.id, created_at: (Time.current + 1.98))
        ResponsesTracking.update_end_time(@passages.fifth.id, @users.first.id)
        expected_remaining_time = ResponsesTracking.remaining_time(@passages.fifth.id, @users.first.id)

        expect(expected_remaining_time.round).to be(0)
      end
    end
    context 'when the duration of the passage id zero' do
      it 'should give the remaining time as the duration till conculde time' do
        passage = @passages.fourth
        user = @users.first
        expected_remaining_time = ResponsesTracking.remaining_time(passage.id, user.id)
        expect(expected_remaining_time.round).to be(172_800)
      end
      it 'should give remaining time 0 if the response has been submitted' do
        passage = @passages.fourth
        ResponsesTracking.create(passage_id: passage.id, user_id: @users.first.id, created_at: (Time.current + 1.98))
        ResponsesTracking.update_end_time(passage.id, @users.first.id)
        expected_remaining_time = ResponsesTracking.remaining_time(passage.id, @users.first.id)

        expect(expected_remaining_time.round).to be(0)
      end
    end
  end
end
