# frozen_string_literal: true

describe EvaluatorJob do
  describe '#execute' do
    it 'should return if there is no job in queue' do
      queue = double('queue')
      expect(queue).to receive(:fetch).and_return nil
      EvaluatorJob.new.execute(queue, nil, nil)
    end

    it 'should execute job if job is present' do
      queue = double('queue')
      response_text = 'response_text'
      passage_text = 'passage_text'
      job = double('job', passage_text: passage_text, response_text: response_text)
      engine = double('engine')
      results = []
      tagger = double('tagger')

      expect(queue).to receive(:fetch).and_return job
      expect(engine).to receive(:evaluate).with(passage_text, response_text).and_return results
      expect(tagger).to receive(:generate_taggings).with(job, results)
      expect(queue).to receive(:ack).with job

      EvaluatorJob.new.execute(queue, engine, tagger)
    end
  end
end
