require './lib/evaluator/tagger'

describe Tagger do

  describe '#get_tag' do
    context 'if tag exists' do
      it 'should get the tag with the name' do
        err = double('err', type: 'err_type', description: 'err_description')
        tag = double('tag')

        expect(Tag).to receive(:find_by).with(name: err.type+' error').and_return tag

        job = Tagger.new
        expect(job.send(:get_tag, err)).to eq tag
      end
    end

    context 'if tag does not exists' do
      it 'should create the tag with the name' do
        err = double('err', type: 'err_type', description: 'err_description')
        tag = double('tag')

        expect(Tag).to receive(:find_by).with(name: err.type+' error').and_return nil
        expect(Tag).to receive(:create).with(name: err.type+' error', description: err.description).and_return tag

        job = Tagger.new
        expect(job.send(:get_tag, err)).to eq tag
      end
    end
  end

end