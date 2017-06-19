# frozen_string_literal: true

describe SessionsController, type: :controller do
  let(:user_info) { { id: 12_234, auth_id: 'auth_id', name: 'first_name last_name', email: 'someone@email.com', image_url: 'https://something.com/profile_picture' } }
  let(:new_user_info) { { id: 12_235, auth_id: 'auth_id', name: 'new user first_name last_name', email: 'someone@email.com', image_url: 'https://something.com/new_user_profile_picture' } }
  before(:each) do
    stub_current_active_user
  end
  describe 'GET #new' do
    context 'When user is logged_in' do
      it 'redirects to passages path' do
        stub_logged_in(true)

        get :new
        expect(response).to redirect_to(passages_path)
      end
    end

    context 'When user is not logged_in' do
      it 'should render login page' do
        stub_logged_in(false)

        get :new
        should render_template(:new)
      end
    end
  end

  describe 'GET #create' do
    context 'When user exists' do
      it 'should not create a new user' do
        allow_any_instance_of(SessionsController).to receive(:user_params).and_return(user_info)
        user = double('user', id: user_info[:id], name: user_info[:name], image_url: user_info[:image_url])

        expect(User).to receive(:find_by).with(email: user_info[:email]).and_return(user)
        expect(user).to receive(:update_if_changed).with(user_info).and_return(user)

        post :create, params: { provider: 'provider' }

        session = controller.session

        expect(response).to redirect_to(passages_path)
        expect(session[:user_id]).to eql(12_234)
        expect(session[:user_name]).to eql('first_name last_name')
        expect(session[:user_image_url]).to eql('https://something.com/profile_picture')
      end
    end

    context 'When user does not exist' do
      it 'should create a new user' do
        allow_any_instance_of(SessionsController).to receive(:user_params).and_return(new_user_info)

        user = double('user', id: new_user_info[:id], name: new_user_info[:name], image_url: new_user_info[:image_url])

        expect(User).to receive(:find_by).with(email: new_user_info[:email]).and_return(nil)
        expect(User).to receive(:create).with(new_user_info).and_return(user)
        expect(user).to receive(:update_if_changed).with(new_user_info).and_return(user)

        post :create, params: { provider: 'provider' }

        session = controller.session

        expect(response).to redirect_to(passages_path)
        expect(session[:user_id]).to eql(12_235)
        expect(session[:user_name]).to eql('new user first_name last_name')
        expect(session[:user_image_url]).to eql('https://something.com/new_user_profile_picture')
      end
    end
  end

  describe 'GET #destroy' do
    it 'should delete the session' do
      my_session = { session_id: 'session_id' }

      delete :destroy, session: my_session

      expect(session[:id]).to be(nil)
      expect(response).to redirect_to(login_path)
    end
  end
end
