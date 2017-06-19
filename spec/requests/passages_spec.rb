# frozen_string_literal: true

RSpec.describe 'Passages', type: :request do
  describe 'GET /passages' do
    it 'works! (now write some real specs)' do
      get passages_path
      expect(response).to have_http_status(302)
    end
  end
end
