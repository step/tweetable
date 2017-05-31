describe PassagesHelper, type: :helper do

  describe 'to_preferred_time_format' do
    it 'converts the time into preffered format' do
      expect(helper.to_preferred_time_format(DateTime.civil(2017, 05, 3, 4, 5, 6))).to eq('03-05-2017 04:05AM')
    end
  end

  describe 'to_specified_time_format' do
    it 'converts the time into specified format' do
      expect(helper.to_display_time_format(DateTime.civil(2017,05,3,4,5,6))).to eq('03 May 04:05 AM')
    end
  end

  describe 'drafts_passage_partial?' do
    it 'should return true when its a drafts passage pertial' do
      expect(helper.drafts_passage_partial?('drafts_passages')).to eq(true)
    end

    it 'should return false when its not a drafts passage pertial' do
      expect(helper.drafts_passage_partial?('concluded_passages')).to eq(false)
    end
  end

  describe 'duration_of_interval_in_words' do
    it 'converts the seconds 3600 into 1 hour' do
      expect(helper.duration_of_interval_in_words(3600)).to eq('1 hour')
    end
    it 'converts the seconds 1800 into 30 minutes' do
      expect(helper.duration_of_interval_in_words(1800)).to eq('30 minutes')
    end
    it 'converts the seconds 5400 into 1 hour 30 minutes' do
      expect(helper.duration_of_interval_in_words(5400)).to eq('1 hour, 30 minutes')
    end
    it 'converts the seconds 2700 into 45 minutes' do
      expect(helper.duration_of_interval_in_words(2700)).to eq('45 minutes')
    end
    it 'converts the seconds 2760 into 46 minutes' do
      expect(helper.duration_of_interval_in_words(2760)).to eq('46 minutes')
    end
    it 'gives null if time is less than one minute' do
      expect(helper.duration_of_interval_in_words(10)).to eq('')
    end
  end

end
