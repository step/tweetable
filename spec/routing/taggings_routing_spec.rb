# frozen_string_literal: true

describe TaggingsController, type: :routing do
  describe 'routing' do
    it 'routes to #create_tagging_by_tag_name' do
      expect(post: '/responses/1/taggings/create_tagging_by_tag_name').to route_to('taggings#create_tagging_by_tag_name', response_id: '1')
    end

    it 'routes to #delete_tagging_by_tag_name' do
      expect(delete: '/responses/1/taggings/delete_tagging_by_tag_name').to route_to('taggings#delete_tagging_by_tag_name', response_id: '1')
    end
  end
end
