# frozen_string_literal: true

describe ErrorsController do
  before(:each) do
    stub_logged_in(true)
    stub_current_active_admin_user
  end

  describe 'GET #not_found' do
    it 'returns http success' do
      get :not_found
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'GET #internal_server_error' do
    it 'returns http success' do
      get :internal_server_error
      expect(response).to have_http_status(:internal_server_error)
    end
  end
end
