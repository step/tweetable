# frozen_string_literal: true

RSpec.describe User, type: :model do
  it { should validate_presence_of(:email) }

  it { should validate_uniqueness_of(:email) }

  it { should validate_uniqueness_of(:auth_id) }

  it 'should validate email with the given domain' do
    ENV.stub(:[]).with('ALLOWED_DOMAIN').and_return('domain')
    user = User.new(email: 'user@domain.com')
    expect(user.save).to be true
  end

  it 'should validate email with any domain if domain is not provided' do
    user = User.new(email: 'user@foobar.com')
    expect(user.save).to be true
  end

  it 'should throw error if given email is not vaild with the domain' do
    ENV.stub(:[]).with('ALLOWED_DOMAIN').and_return('domain')
    user = User.new(email: 'user@otherdomain.com')
    expect(user.save).to be false
    expect(user.errors.full_messages).to include('Email must be a valid email id...')
  end
end
