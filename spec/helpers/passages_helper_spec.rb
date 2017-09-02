# frozen_string_literal: true

describe PassagesHelper, type: :helper do
  describe 'to_preferred_time_format' do
    it 'converts the time into preffered format' do
      expect(helper.to_preferred_time_format(DateTime.civil(2017, 0o5, 3, 4, 5, 6))).to eq('03-05-2017 04:05AM')
    end
  end

  describe 'to_specified_time_format' do
    it 'converts the time into specified format' do
      expect(helper.to_display_time_format(DateTime.civil(2017, 0o5, 3, 4, 5, 6))).to eq('03 May 04:05 AM')
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
    it 'converts the seconds 613200 into 7D : 2H : 20M' do
      expect(PassagesHelper.duration_of_interval_in_words(613_200)).to eq('7 days, 2 hours, 20 minutes')
    end
    it 'converts the seconds 86520 into 1D : 2M' do
      expect(PassagesHelper.duration_of_interval_in_words(86_520)).to eq('1 day, 2 minutes')
    end
    it 'converts the seconds 3600 into 1 hour' do
      expect(PassagesHelper.duration_of_interval_in_words(3600)).to eq('1 hour')
    end
    it 'converts the seconds 1800 into 30 minutes' do
      expect(PassagesHelper.duration_of_interval_in_words(1800)).to eq('30 minutes')
    end
    it 'converts the seconds 5400 into 1 hour 30 minutes' do
      expect(PassagesHelper.duration_of_interval_in_words(5400)).to eq('1 hour, 30 minutes')
    end
    it 'gives null if time is less than one minute' do
      expect(PassagesHelper.duration_of_interval_in_words(10)).to eq('10 seconds')
    end
  end

  describe 'evaluation_count' do
    it 'should return zero when evaluation still pending for a response' do
      response1 = double('Response', text: 'This is a passage text', passage_id: 1, id: 1)

      expect(response1).to receive(:tags).and_return(nil)
      expect(helper.evaluation_count([response1])).to eq(0)
    end

    it 'should return 2 when admin evaluated two responses' do
      response1 = double('Response', text: 'response', passage_id: 1, id: 1)
      response2 = double('Response', text: 'another response', passage_id: 1, id: 2)
      tag1 = double('Tag', name: 'Grammatical Error', id: 1)
      tag2 = double('Tag', name: 'Type Error', id: 2)

      expect(response1).to receive(:tags).and_return([tag1])
      expect(response2).to receive(:tags).and_return([tag2])

      expect(helper.evaluation_count([response1, response2])).to eq(2)
    end

    it 'should return 1 when admin evaluated 1 response and another response evaluation is left' do
      response1 = double('Response', text: 'response', passage_id: 1, id: 1)
      response2 = double('Response', text: 'another response', passage_id: 1, id: 2)
      tag1 = double('Tag', name: 'Grammatical Error', id: 1)
      tag2 = double('Tag', name: 'Type Error', id: 2)

      expect(response1).to receive(:tags).and_return([tag1, tag2])
      expect(response2).to receive(:tags).and_return(nil)

      expect(helper.evaluation_count([response1, response2])).to eq(1)
    end

    it 'should return zero when there is no tag associate with response' do
      response1 = double('Response', text: 'response', passage_id: 1, id: 1)

      expect(response1).to receive(:tags).and_return([])

      expect(helper.evaluation_count([response1])).to eq(0)
    end
  end

  describe '#partial_name' do
    it 'should return the correspondent passage partial_name' do
      expect(PassagesHelper.partial_name(:drafts)).to eq('drafts_passages')
      expect(PassagesHelper.partial_name(:attempted)).to eq('attempted_passages')
    end
    it 'should return the nil partial_name when tab name is different' do
      expect(PassagesHelper.partial_name(:attempt)).to eq(nil)
    end
  end

  describe '#empty_tab_messages' do
    it 'should return the correspondent empty passage message based on tab name' do
      expect(PassagesHelper.empty_tab_messages(:attempted_passages.to_s)).to eq('You have not yet attempted any passages.')
    end
    it 'should return the nil empty message when partial_name is different' do
      expect(PassagesHelper.partial_name(:attempt.to_s)).to eq(nil)
    end
  end
end
