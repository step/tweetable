# frozen_string_literal: true

require 'timecop'
describe Passage, type: :model do
  describe 'validations ' do
    it { should validate_presence_of(:title) }

    it { should validate_presence_of(:text) }

    it { should validate_numericality_of(:duration).is_greater_than_or_equal_to(0) }

    it 'validate if commence time and conclude time is nil' do
      passage = Passage.new(title: 'passage title', text: 'passage text', duration: 86_400)
      expect(passage.save).to be true
    end

    it 'validate if commence time is nil and conclude time is given' do
      passage = Passage.new(title: 'passage title', text: 'passage text', duration: 86_400, conclude_time: Time.current)
      expect(passage.save).to be true
    end

    it 'validate if commence time present and conclude time past time with commence time' do
      current_time = Time.current
      past_time = current_time - 4.days
      passage = Passage.new(title: 'passage title', text: 'passage text', duration: 86_400, commence_time: current_time, conclude_time: past_time)
      expect(passage.save).to be false
      expect(passage.errors.full_messages).to include('Conclude time must be a future time...')
    end

    it 'validate for conclude time present time' do
      current_time = Time.current
      past_time = current_time - 4.days
      passage = Passage.new(title: 'passage title', text: 'passage text', duration: 86_400, commence_time: past_time, conclude_time: current_time)
      expect(passage.save).to be true
    end
  end

  describe 'associations' do
    it { should have_many(:responses).dependent(:destroy) }
  end

  describe 'scope' do
    context 'recently_commenced' do
      it 'get all passage commenced within one day' do
        passage_one = Passage.create! title: 'Title 1', text: 'passage 1 text', duration: 86_400
        passage_two = Passage.create! title: 'Title 2', text: 'passage 2 text', duration: 86_400
        Passage.create! title: 'Title 3', text: 'passage 3 text', duration: 86_400

        Timecop.scale(2.months.seconds)

        passage_one.commence Time.current.advance days: 4
        passage_two.commence Time.current.advance days: 4
        passage_two.conclude

        expect(Passage.recently_commenced.to_a).to eq([passage_one])
        Timecop.return
      end
    end
  end

  describe 'commence' do
    it 'should set the conclude time as current time' do
      Time.zone = 'Astana'
      passage = Passage.create(title: 'passage title', text: 'passage text', duration: 86_400)
      now = Time.now.in_time_zone(ActiveSupport::TimeZone.new('Chennai'))
      passage.commence(now.to_s)
      expect(passage.conclude_time).to eq(Time.zone.parse(now.to_s))
    end
  end

  describe 'open_passages' do
    it 'should get all open passages' do
      now = Time.current
      expect(Time).to receive(:current).and_return(now)
      expect(Passage).to receive(:where).with(['commence_time <= ? and conclude_time > ?', now, now]).and_return([])
      Passage.ongoing
    end
  end

  describe 'draft_passages' do
    it 'should get all draft passages' do
      now = Time.current
      expect(Time).to receive(:current).and_return(now)
      passage_or = double('OR')
      expect(Passage).to receive(:where).with(commence_time: nil)
      expect(passage_or).to receive(:or)
      expect(Passage).to receive(:where).with(['commence_time > ?', now]).and_return(passage_or)
      Passage.drafts
    end
  end

  describe '#concluded_passages' do
    it 'should get all concluded passages' do
      now = Time.current
      expect(Time).to receive(:current).and_return(now)
      expect(Passage).to receive(:where).with(['conclude_time < ?', now])
      Passage.concluded
    end
  end

  describe 'commence_for_candidate_passages' do
    it 'should get all open passages for the candidate which are not attempted by user' do
      passage1 = double('Passage 1', id: 11)
      passage2 = double('Passage 2', id: 12)
      user = double('User', id: 1)

      expect(Passage).to receive(:ongoing).and_return([passage1, passage2])
      expect(user).to receive(:passages).and_return([passage1])
      passage_open_for_candidate = Passage.commence_for_candidate(user)

      expect(passage_open_for_candidate.count).to be(1)
      expect(passage_open_for_candidate).to contain_exactly(passage2)
    end
    it 'should not get passages that are open but remaining time is expired' do
      passage1 = double('Passage 1', id: 11)
      passage2 = double('Passage 2', id: 12)
      user = double('User', id: 1)
      tracking_details2 = double('Responses Tracking')

      expect(Passage).to receive(:ongoing).and_return([passage1, passage2])
      expect(user).to receive(:passages).and_return([])
      expect(ResponsesTracking).to receive(:find_by).with(passage_id: passage1.id, user_id: user.id).and_return(nil)
      expect(ResponsesTracking).to receive(:find_by).with(passage_id: passage2.id, user_id: user.id).and_return(tracking_details2)
      expect(ResponsesTracking).to receive(:remaining_time).and_return(0)

      passage_open_for_candidate = Passage.commence_for_candidate(user)

      expect(passage_open_for_candidate.count).to be(1)
      expect(passage_open_for_candidate).to contain_exactly(passage1)
    end
  end

  describe '#missed_by_candidate_passages' do
    it 'should get all missed passages for the candidate which are not attempted by user' do
      passage1 = double('Passage 1', id: 11, duration: 4600)
      passage2 = double('Passage 2', id: 12)
      user = double('User', id: 1)

      expect(Passage).to receive(:concluded).and_return([passage1, passage2])
      expect(user).to receive(:passages).and_return([passage1])
      passage_missed_for_candidate = Passage.missed_by_candidate(user)

      expect(passage_missed_for_candidate.count).to be(1)
      expect(passage_missed_for_candidate).to contain_exactly(passage2)
    end
    it 'should get all missed passages for the candidate which are not attempted by user in the remaining time' do
      concluded_psg1 = double('Passage 1', id: 11, duration: 4600)
      concluded_psg2 = double('Passage 2', id: 12)
      ongoing_psg1 = double('Passage 3', id: 13)
      ongoing_psg2 = double('Passage 4', id: 14)
      tracking_details2 = double('Responses Tracking')

      user = double('User', id: 1)

      expect(Passage).to receive(:concluded).and_return([concluded_psg1, concluded_psg2])
      expect(user).to receive(:passages).and_return([concluded_psg2])
      expect(Passage).to receive(:ongoing).and_return([ongoing_psg1, ongoing_psg2])
      expect(ResponsesTracking).to receive(:find_by).with(passage_id: ongoing_psg1.id, user_id: user.id).and_return(nil)
      expect(ResponsesTracking).to receive(:find_by).with(passage_id: ongoing_psg2.id, user_id: user.id).and_return(tracking_details2)
      expect(ResponsesTracking).to receive(:remaining_time).with(ongoing_psg2.id, user.id).and_return(0)

      passage_missed_for_candidate = Passage.missed_by_candidate(user)

      expect(passage_missed_for_candidate.count).to be(2)
      expect(passage_missed_for_candidate).to contain_exactly(concluded_psg1, ongoing_psg2)
    end
    it 'should not get the passage whose remaining time is not less than or equal to zero' do
      concluded_psg1 = double('Passage 1', id: 11, duration: 4600)
      concluded_psg2 = double('Passage 2', id: 12)
      ongoing_psg1 = double('Passage 3', id: 13)
      ongoing_psg2 = double('Passage 4', id: 14)
      tracking_details2 = double('Responses Tracking')

      user = double('User', id: 1)

      expect(Passage).to receive(:concluded).and_return([concluded_psg1, concluded_psg2])
      expect(user).to receive(:passages).and_return([concluded_psg2])
      expect(Passage).to receive(:ongoing).and_return([ongoing_psg1, ongoing_psg2])
      expect(ResponsesTracking).to receive(:find_by).with(passage_id: ongoing_psg1.id, user_id: user.id).and_return(nil)
      expect(ResponsesTracking).to receive(:find_by).with(passage_id: ongoing_psg2.id, user_id: user.id).and_return(tracking_details2)
      expect(ResponsesTracking).to receive(:remaining_time).with(ongoing_psg2.id, user.id).and_return(10)

      passage_missed_for_candidate = Passage.missed_by_candidate(user)

      expect(passage_missed_for_candidate.count).to be(1)
      expect(passage_missed_for_candidate).to contain_exactly(concluded_psg1)
    end
    it 'should not get the passage whose response is already submitted' do
      concluded_psg1 = double('Passage 1', id: 11, duration: 4600)
      concluded_psg2 = double('Passage 2', id: 12)
      ongoing_psg1 = double('Passage 3', id: 13)
      ongoing_psg2 = double('Passage 4', id: 14)
      tracking_details2 = double('Responses Tracking')

      user = double('User', id: 1)

      expect(Passage).to receive(:concluded).and_return([concluded_psg1, concluded_psg2])
      expect(user).to receive(:passages).and_return([concluded_psg2, ongoing_psg2])
      expect(Passage).to receive(:ongoing).and_return([ongoing_psg1, ongoing_psg2])
      expect(ResponsesTracking).to receive(:find_by).with(passage_id: ongoing_psg1.id, user_id: user.id).and_return(nil)
      expect(ResponsesTracking).to receive(:find_by).with(passage_id: ongoing_psg2.id, user_id: user.id).and_return(tracking_details2)
      expect(ResponsesTracking).to receive(:remaining_time).with(ongoing_psg2.id, user.id).and_return(0)

      passage_missed_for_candidate = Passage.missed_by_candidate(user)

      expect(passage_missed_for_candidate.count).to be(1)
      expect(passage_missed_for_candidate).to contain_exactly(concluded_psg1)
    end
  end

  describe '#attended_passage_by_candidate' do
    context 'get all attended passages with response' do
      it 'should belongs to the logged candidate ' do
        passage1 = double('Passage', id: 11)

        response1 = double('Response', id: 1, passage_id: 11)

        user = double('User', passages: [passage1], responses: [response1])

        attempted_by_candidate = Passage.attempted_by_candidate(user)

        expect(attempted_by_candidate).to eq([{ passage: passage1, response: response1 }])
      end

      it 'should get empty if attempted passage is zero ' do
        user = double('User', passages: [], responses: [])

        attempted_by_candidate = Passage.attempted_by_candidate(user)

        expect(attempted_by_candidate).to be_empty
      end
    end
  end
end
