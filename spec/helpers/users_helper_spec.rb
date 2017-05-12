require 'rails_helper'

RSpec.describe UsersHelper, type: :helper do
  let(:users) {

    [
        {
            name: 'Kamal Hasan', admin: false, auth_id: '132271', image_url: 'http://graph.facebook.com/demo1'
        },
        {
            name: 'Vimal Hasan', admin: false, auth_id: '132273', image_url: 'http://graph.facebook.com/demo1'
        },
        {
            name: 'Rajanikanth', admin: false, auth_id: '132272', image_url: 'http://graph.facebook.com/demo2'
        }
    ]
  }

  let(:passages) {
    [
        {
            title: 'Climate Change', text: 'climate change passage', start_time: DateTime.now, close_time: (DateTime.now+2), duration: '1'
        },

        {
            title: 'Person', text: 'person passage', start_time: DateTime.now, close_time: (DateTime.now+1), duration: '2'
        },

        {
            title: 'News', text: 'news passage', start_time: (DateTime.now-2), close_time: (DateTime.now-1), duration: '2'
        },
        {
            title: 'Program', text: 'program passage', start_time: (DateTime.now-3), close_time: (DateTime.now+1), duration: '2'
        },
        {
            title: 'Class', text: 'class passage', start_time: (DateTime.now-3), close_time: (DateTime.now-1), duration: '2'
        }
    ]

  }
  let(:responses) { [
      {
          text: "respose for Climate Changed", user_id: User.find_by(auth_id: '132271').id, passage_id: Passage.find_by(title: 'Climate Change').id
      },
      {
          text: "respose for Climate Changed", user_id: User.find_by(auth_id: '132273').id, passage_id: Passage.find_by(title: 'Climate Change').id
      },
      {
          text: "respose for Person", user_id: User.find_by(auth_id: '132271').id, passage_id: Passage.find_by(title: 'Person').id
      },
      {
          text: "respose for Person", user_id: User.find_by(auth_id: '132273').id, passage_id: Passage.find_by(title: 'Person').id
      },
      {
          text: "News Response", user_id: User.find_by(auth_id: '132273').id, passage_id: Passage.find_by(title: 'News').id
      }
  ]
  }
  before(:each) do
    @users = User.create(users)
    @passages = Passage.create(passages)
  end

  after(:each) do
    @passages.each(&:delete)
    @users.each(&:delete)
  end

  it 'should get all open passages count to be three' do
    user = @users.first
    expect(open_passages(user).count).to be(3)
  end

  it 'should get all open passages titles' do
    user = @users.first
    opened_titles = open_passages(user).map {|x| x.title }
    expect(opened_titles).to contain_exactly('Climate Change', 'Person', 'Program')
  end

  it 'while getting all open passages user should get not get his/her attempted passages' do
    user1 = @users.first
    user2 = @users.second
    user3 = @users.third
    @responses = Response.create(responses)
    expect(open_passages(user1).count).to be(1)
    expect(open_passages(user2).count).to be(1)
    expect(open_passages(user3).count).to be(3)
    @responses.each(&:delete)
  end
end
