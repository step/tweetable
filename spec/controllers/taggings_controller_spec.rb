# frozen_string_literal: true

describe TaggingsController, type: :controller do
  before(:each) do
    stub_logged_in(true)
    stub_current_active_admin_user
  end

  describe 'POST #create_tagging_by_tag_name' do
    it 'should create a new tagging with id of given tag name' do
      tag_name = 'tag_name'
      tag = double('tag')
      taggings = double('taggings')
      response_id = 'response_id'

      expect(Tag).to receive(:find_or_create_by).with(name: tag_name).and_return(tag)
      expect(tag).to receive(:taggings).and_return(taggings)
      expect(taggings).to receive(:create).with(response_id: response_id)

      post :create_tagging_by_tag_name, params: { response_id: response_id, tag_name: tag_name }
    end
  end

  describe 'DELETE #delete_tagging_by_tag_name' do
    it 'should create a delete tagging with id of given tag name' do
      tag_name = 'tag_name'
      tag = double('tag')
      tagging = double('tagging')
      response_id = 'response_id'
      tag_id = 'tag_id'

      expect(Tag).to receive(:find_by).with(name: tag_name).and_return(tag)
      expect(tag).to receive(:id).and_return(tag_id)
      expect(Tagging).to receive(:find_by).with(response_id: response_id, tag_id: tag_id).and_return(tagging)
      expect(tagging).to receive(:destroy)

      post :delete_tagging_by_tag_name, params: { response_id: response_id, tag_name: tag_name }
    end
  end

  describe 'PUT #review_taggings' do
    it 'should update all the taggings reviewed to be true' do
      response_id = 'response_id'
      response = double('response')
      taggings = double('taggings')

      expect(Response).to receive(:find).with(response_id).and_return response
      expect(response).to receive(:taggings).and_return taggings
      expect(taggings).to receive(:update_all).with reviewed: true

      put :review_taggings, params: { response_id: response_id }
    end
  end
end
