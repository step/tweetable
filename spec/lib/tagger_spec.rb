# frozen_string_literal: true

require './lib/evaluator/tagger'

describe Tagger do
  describe '#get_tag' do
    context 'if tag exists' do
      it 'should get the tag with the name' do
        err = double('err', type: 'err_type', description: 'err_description')
        tag = double('tag')

        expect(Tag).to receive(:find_by).with(name: err.type + ' error').and_return tag

        job = Tagger.new
        expect(job.get_tag(err)).to eq tag
      end
    end

    context 'if tag does not exists' do
      it 'should create the tag with the name' do
        err = double('err', type: 'err_type', description: 'err_description')
        tag = double('tag')

        expect(Tag).to receive(:find_by).with(name: err.type + ' error').and_return nil
        expect(Tag).to receive(:create).with(name: err.type + ' error', description: err.description).and_return tag

        job = Tagger.new
        expect(job.get_tag(err)).to eq tag
      end
    end
  end

  describe '#generate_taggings' do
    it 'generate taggings on all the given error' do
      err = double('err', type: 'err_type', description: 'err_description')
      response_id = 'response_id'
      job = double('job')
      results = [err]
      tagger = Tagger.new
      tag = double('tag')
      taggings = double('taggings')

      expect(job).to receive(:response_id).and_return response_id
      expect(tagger).to receive(:get_tag).with(err).and_return tag
      expect(tag).to receive(:taggings).and_return taggings
      expect(taggings).to receive(:create).with(response_id: response_id)

      tagger.generate_taggings job, results
    end
  end
end
