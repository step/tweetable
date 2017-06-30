# frozen_string_literal: true

describe TagsController, type: :controller do
  let(:un_authrised_message) { "Either the resource you have requested does not exist or you don't have access to them" }
  before(:each) do
    stub_logged_in(true)
  end

  context 'Index' do
    context 'For Admin User' do
      it 'should return all the tags' do
        stub_current_active_admin_user
        get :index
        expect(response).to render_template(:index)
      end
    end
    context 'For Non Admin User' do
      it 'should not return all the tags' do
        stub_current_active_intern_user
        expect { get :index }.to raise_error(ActionController::RoutingError)
      end
    end
  end

  context 'New' do
    context 'For Admin User' do
      it 'should render new tag template' do
        stub_current_active_admin_user
        get :new
        expect(response).to render_template(:new)
      end
    end
    context 'For Non Admin User' do
      it 'should not return all the tags' do
        stub_current_active_intern_user
        expect { get :new }.to raise_error(ActionController::RoutingError)
      end
    end
  end

  context 'Create' do
    context 'For Admin User' do
      it 'should create a tag' do
        stub_current_active_admin_user
        get :create, params: { tag: { name: 'New tag', weight: 2, description: 'Discriptions for new tag', color: '#abc234' } }
        expect(flash[:success]).to match('Tag was successfully created')
        expect(response).to redirect_to(tags_path)
      end
      it 'should not create a tag' do
        stub_current_active_admin_user
        get :create, params: { tag: { name: 'New tag', weight: 2, description: 'Discriptions for new tag', color: '#gbc234' } }
        expect(flash[:danger]).to match('Color code must be a valid hex color code')
        expect(response).to redirect_to(tags_path)
      end
    end
    context 'For Non Admin User' do
      it 'should not create tag' do
        stub_current_active_intern_user
        params = { name: 'New tag', weight: 2, description: 'Discriptions for new tag' }
        expect { get :create, params: params }.to raise_error(ActionController::RoutingError)
      end
    end
  end
end
