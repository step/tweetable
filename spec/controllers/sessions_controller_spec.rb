describe SessionsController, type: :controller do

  let(:user_info) {{auth_id: 'auth_id', name: 'first_name last_name', email: 'someone@email.com', image_url: 'https://something.com/profile_picture'}}

  describe 'GET #new' do

    context 'When user is logged_in' do
      it 'redirects to passages path' do
        stub_logged_in(true)
        get :new
        expect(response).to redirect_to(conformation_users_path)
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
    before(:each) do
      allow_any_instance_of(SessionsController)
          .to receive(:user_params)
                  .and_return(user_info)
    end

    context 'When user exists' do

        it 'should not create a new user' do
          user = double('user')

          expect(User).to receive(:find_by).with(email: user_info[:email]).and_return(user)
          expect(user).to receive(:update_if_changed).with(user_info)
          expect(controller).to receive(:assign_session_details)

          post :create, params: {provider: 'provider'}

          expect(response).to redirect_to(conformation_users_path)
        end

    end

    context 'When user does not exist' do
      it 'should create a new user' do
        user = double('user')

        expect(User).to receive(:find_by).with(email: user_info[:email]).and_return(nil)
        expect(User).to receive(:create).with(user_info).and_return(user)
        expect(user).to receive(:update_if_changed).with(user_info)
        expect(controller).to receive(:assign_session_details)

        post :create, params: {provider: 'provider'}

        expect(response).to redirect_to(conformation_users_path)
      end
    end

  end

  describe 'GET #destroy' do
    it 'should delete the session' do
      my_session = {session_id: 'session_id'}

      delete :destroy, session: my_session

      expect(session[:id]).to be(nil)
      expect(response).to redirect_to(login_path)
    end
  end
end