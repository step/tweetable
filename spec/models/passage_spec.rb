require 'rails_helper'

RSpec.describe Passage, type: :model do

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
        },
        {
            title: 'Computer', text: 'computer passage', start_time: (DateTime.now+3), close_time: (DateTime.now+7), duration: '2'
        },
        {
            title: 'Human', text: 'human passage', start_time: nil, close_time: nil, duration: '2'
        }
    ]

  }

  before(:each) do
    @passages = Passage.create(passages)
  end

  after(:each) do
    @passages.each(&:delete)
  end

  describe "validations " do
    it {should validate_presence_of(:title)}

    it {should validate_presence_of(:text)}

    it {should validate_presence_of(:duration)}
  end


  describe "open_passages" do
    it 'should get all open passages count to be three' do
      expect(Passage.open_passages.count).to be(3)
    end
    it 'should get all open passages titles' do
      opened_titles = Passage.open_passages.map(&:title)
      expect(opened_titles).to contain_exactly('Climate Change', 'Person', 'Program')
    end
  end

  describe "draft_passages" do
    it 'should get all draft passages count to be three' do
      expect(Passage.draft_passages.count).to be(2)
    end
    it 'should get all open passages titles' do
      opened_titles = Passage.draft_passages.map(&:title)
      expect(opened_titles).to contain_exactly('Computer', 'Human')
    end
  end

  describe "closed_passages" do
    it 'should get all closed passages count to be three' do
      expect(Passage.closed_passages.count).to be(2)
    end
    it 'should get all open passages titles' do
      opened_titles = Passage.closed_passages.map(&:title)
      expect(opened_titles).to contain_exactly('News', 'Class')
    end
  end
end
