describe UsersController, type: :controller do
  before(:each) do
    stub_logged_in(true)

  end

  let(:valid_attributes) {
    {
        active: '0',
        admin: '0'
    }
  }

  let(:params_to_permit) {
    {
        active: false,
        admin: false
    }
  }

  describe 'GET #conformation' do

    it 'should render conformation if user is not a active user' do
      user = double('User', admin: false, id: 1, active: false)
      stub_current_user(user)

      get :conformation, params: {id: user.id}
      should render_template('conformation')
    end

    it 'should redirect to passage path if user is active user' do
      user = double('User', admin: false, id: 1, active: true)
      stub_current_user(user)

      get :conformation, params: {id: user.id}
      expect(response).to redirect_to(passages_path)
    end

  end

  describe 'GET #index' do

    it 'should index active user' do
      user = double('User', admin: false, id: 1, active: false)
      stub_current_user(user)

      get :index, params: {id: user.id}
      should render_template('index')
    end
  end

  describe 'PUT #update' do

    context 'with valid params' do
      it 'update the user record' do
        user = double('User', admin: true, id: 1, active: true)
        stub_current_user(user)

        expect(User).to receive(:find).and_return(user)
        allow_any_instance_of(UsersController).to receive(:permit_params).and_return(params_to_permit)
        expect(user).to receive(:update_attributes).with(params_to_permit).and_return(true)

        put :update, params: {id: user.id, user: valid_attributes}

        # TODO add test while assertion
        # expect(user.active).to   eq(false)

      end
    end
  end
end
