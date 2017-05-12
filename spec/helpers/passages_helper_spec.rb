require 'rails_helper'

RSpec.describe PassagesHelper, type: :helper do
  let(:passages) {

    [
        {
            title: 'Climate Changed', text: 'Climate change text', start_time: DateTime.now, close_time: (DateTime.now + 2), duration: '1'
        },

        {
            title: 'Person', text: 'hello world', start_time: (DateTime.now -1), close_time: (DateTime.now + 3), duration: '2'
        },

        {
            title: 'Missed person', text: 'hello world', start_time: (DateTime.now -3), close_time: (DateTime.now -1), duration: '2'
        },
        {
            title: 'OPEN without responses', text: 'hello world', start_time: DateTime.now, close_time: (DateTime.now +2), duration: '2'
        },
        {
            title: 'CLOSED without responses', text: 'hello world', start_time: (DateTime.now -3), close_time: (DateTime.now -1), duration: '2'
        }
    ]
  }
  before(:each) do
    @passages = Passage.create!(passages)
  end

  after(:each) do
    @passages.each(&:delete)
  end


  describe "to_preffered_time_format" do
    it "converts the time into preffered format" do
      expect(helper.to_preffered_time_format(DateTime.new(2017,05,3,4,5,6))).to eq("03-05-2017 04:05AM")
    end
  end

  describe "get_passage_by_status_path" do
    it "appends the status with the get_passage_by_status_path" do
      expect(helper.get_passage_by_status_path("DRAFT")).to eq("/passages/get_passage_by_status/DRAFT")
    end
  end

  it 'should get all open passage' do
    expect(open_passages.count).to be(3)
  end
  it 'should get all closed passage' do
    expect(closed_passages.count).to be(2)
  end

end
