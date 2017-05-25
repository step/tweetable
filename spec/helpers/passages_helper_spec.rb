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

  describe "to_specified_time_format" do
    it "converts the time into specified format" do
      expect(helper.to_display_time_format(DateTime.new(2017,05,3,4,5,6))).to eq("03 May 04:05 AM")
    end
  end

  describe 'drafts_passage_partial?' do
    it 'should return true when its a drafts passage pertial' do
      expect(helper.drafts_passage_partial?('drafts_passages')).to eq(true)
    end

    it 'should return false when its not a drafts passage pertial' do
      expect(helper.drafts_passage_partial?('closed_passages')).to eq(false)
    end
  end

  describe "duration_of_interval_in_words" do
    it "converts the seconds 3600 into 1 hour" do
      expect(helper.duration_of_interval_in_words(3600)).to eq("1 hour")
    end
    it "converts the seconds 1800 into 30 minutes" do
      expect(helper.duration_of_interval_in_words(1800)).to eq("30 minutes")
    end
    it "converts the seconds 5400 into 1 hour 30 minutes" do
      expect(helper.duration_of_interval_in_words(5400)).to eq("1 hour, 30 minutes")
    end
    it "converts the seconds 2700 into 45 minutes" do
      expect(helper.duration_of_interval_in_words(2700)).to eq("45 minutes")
    end
    it "converts the seconds 2760 into 46 minutes" do
      expect(helper.duration_of_interval_in_words(2760)).to eq("46 minutes")
    end
    it "gives null if time is less than one minute" do
      expect(helper.duration_of_interval_in_words(10)).to eq("")
    end
  end

end
