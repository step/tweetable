describe Passage, type: :model do
  describe 'validations ' do

    it {should validate_presence_of(:title)}

    it {should validate_presence_of(:text)}

    it { should validate_numericality_of(:duration).is_greater_than(0) }

  #TODO: write test for custom validation

  end

  describe 'associations' do

    it{ should have_many(:responses).dependent(:destroy)}

  end


  describe 'open_passages' do
    it 'should get all open passages' do
      user = double('User', passages: [],id:2)
      now = DateTime.now
      expect(Passage).to receive(:where).with(['start_time <= ? and close_time > ?', now, now]).and_return([])
      Passage.ongoing(user)
    end
  end

  describe 'draft_passages' do
    it 'should get all draft passages' do
      now = DateTime.now
      passage_or = double('OR')
      expect(Passage).to receive(:where).with(start_time: nil)
      expect(passage_or).to receive(:or)
      expect(Passage).to receive(:where).with(['start_time > ?', now]).and_return(passage_or)
      Passage.drafts
    end
  end

  describe 'closed_passages' do
    it 'should get all closed passages' do
      now = DateTime.now
      expect(Passage).to receive(:where).with(['close_time < ?', now])
      Passage.finished
    end
  end

  describe 'open_for_candidate_passages' do
    it 'should get all open passages for the candidate which are not attempted by user count to be one' do
      passage1 = double('Passage 1',id:11)
      passage2 = double('Passage 2',id:12)
      user = double('User',id:1)

      expect(Passage).to receive(:ongoing).and_return([passage1, passage2])
      expect(user).to receive(:passages).and_return([passage1])
      passage_open_for_candidate = Passage.commence_for_candidate(user)

      expect(passage_open_for_candidate.count).to be(1)
      expect(passage_open_for_candidate).to contain_exactly(passage2)
    end
  end

  describe '#missed_by_candidate_passages' do
    it 'should get all missed passages for the candidate which are not attempted by user count to be one' do
      passage1 = double('Passage 1',id:11,duration:4600)
      passage2 = double('Passage 2',id:12)
      user = double('User',id:1)

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

        passage1 = double('Passage',id:11)

        response1 = double('Response',id:1,passage_id:11)

        user = double('User', passages: [passage1], responses: [response1])

        attempted_by_candidate = Passage.attempted_by_candidate(user)

        expect(attempted_by_candidate).to eq([{passage:passage1,response:response1}])
      end

      it 'should get empty if attempted passage is zero ' do


        user = double('User', passages: [], responses: [])

        attempted_by_candidate = Passage.attempted_by_candidate(user)

        expect(attempted_by_candidate).to be_empty
      end
    end
  end
end
