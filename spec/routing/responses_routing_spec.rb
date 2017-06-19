# frozen_string_literal: true

require 'rails_helper'

describe ResponsesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/passages/1/responses').to route_to('responses#index', passage_id: '1')
    end
  end
end
