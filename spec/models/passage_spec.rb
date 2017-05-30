describe Passage, type: :model do

  describe 'validations ' do

    it {should validate_presence_of(:title)}

    it {should validate_presence_of(:text)}

    it {should validate_numericality_of(:duration).is_greater_than(0)}

    it 'raises an error if close time is lower than current time' do
      current = Time.current
      passage = Passage.create(title: 'passage title', text: 'passage text', duration: 86400, start_time: current, close_time: current - 1.day)
      expect(passage.errors.full_messages).to include('Close time must be a future time...')
    end

    it 'raises an error if close time is lower than start time' do
      current_time = Time.current
      start_time = current_time + 4.days
      close_time = current_time + 2.days
      passage = Passage.create(title: 'passage title', text: 'passage text', duration: 86400, start_time: start_time, close_time: close_time)

      expect(passage.errors.full_messages).to include('Close time must be a future time...')
    end

  end

  describe 'associations' do

    it {should have_many(:responses).dependent(:destroy)}

  end

  describe 'commence' do
    it 'should set the close time as current time' do
      Time.zone = 'Astana'
      passage = Passage.create(title: 'passage title', text: 'passage text', duration: 86400)
      now = Time.now.in_time_zone(ActiveSupport::TimeZone.new('Chennai'))
      passage.commence(now.to_s)
      expect(passage.close_time).to eq(Time.zone.parse now.to_s)
    end
  end

  describe 'open_passages' do
    it 'should get all open passages' do
      user = double('User', passages: [], id: 2)
      now = Time.current
      expect(Time).to receive(:current).and_return(now)
      expect(Passage).to receive(:where).with(['start_time <= ? and close_time > ?', now, now]).and_return([])
      Passage.ongoing(user)

    end
  end

  describe 'draft_passages' do
    it 'should get all draft passages' do
      now = Time.current
      expect(Time).to receive(:current).and_return(now)
      passage_or = double('OR')
      expect(Passage).to receive(:where).with(start_time: nil)
      expect(passage_or).to receive(:or)
      expect(Passage).to receive(:where).with(['start_time > ?', now]).and_return(passage_or)
      Passage.drafts
    end
  end

  describe 'closed_passages' do
    it 'should get all closed passages' do
      now = Time.current
      expect(Time).to receive(:current).and_return(now)
      expect(Passage).to receive(:where).with(['close_time < ?', now])
      Passage.finished
    end
  end

  describe 'open_for_candidate_passages' do
    it 'should get all open passages for the candidate which are not attempted by user count to be one' do
      passage1 = double('Passage 1', id: 11)
      passage2 = double('Passage 2', id: 12)
      user = double('User', id: 1)

      expect(Passage).to receive(:ongoing).and_return([passage1, passage2])
      expect(user).to receive(:passages).and_return([passage1])
      passage_open_for_candidate = Passage.commence_for_candidate(user)

      expect(passage_open_for_candidate.count).to be(1)
      expect(passage_open_for_candidate).to contain_exactly(passage2)
    end
  end

  describe '#missed_by_candidate_passages' do
    it 'should get all missed passages for the candidate which are not attempted by user count to be one' do
      passage1 = double('Passage 1', id: 11, duration: 4600)
      passage2 = double('Passage 2', id: 12)
      user = double('User', id: 1)


      expect(Passage).to receive(:finished).and_return([passage1, passage2])
      expect(user).to receive(:passages).and_return([passage1])
      passage_missed_for_candidate = Passage.missed_by_candidate(user)

      expect(passage_missed_for_candidate.count).to be(1)
      expect(passage_missed_for_candidate).to contain_exactly(passage2)
    end
  end

  describe '#attended_passage_by_candidate' do
    context 'get all attended passages with response' do
      it 'should belongs to the logged candidate ' do

        passage1 = double('Passage', id: 11)

        response1 = double('Response', id: 1, passage_id: 11)

        user = double('User', passages: [passage1], responses: [response1])

        attempted_by_candidate = Passage.attempted_by_candidate(user)

        expect(attempted_by_candidate).to eq([{passage: passage1, response: response1}])
      end

      it 'should get empty if attempted passage is zero ' do


        user = double('User', passages: [], responses: [])

        attempted_by_candidate = Passage.attempted_by_candidate(user)

        expect(attempted_by_candidate).to be_empty
      end
    end
  end
end
