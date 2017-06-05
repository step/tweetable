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

  describe 'GET #index' do

    it 'should index active user' do
      user_params = {admin: false, id: 1, active: true}
      stub_current_user_with_attributes(user_params)
      get :index, params: {id: user_params[:id]}
      should render_template(:index)
    end
  end

  describe 'PUT #update' do

    context 'with valid params' do
      it 'update the user record' do
        user_params = {admin: false, id: 1, active: true}
        stub_current_user_with_attributes(user_params)

        # TODO add test while assertion
        # expect(User).to receive(:find).and_return(user_params)
        # allow_any_instance_of(UsersController).to receive(:permit_params).and_return(params_to_permit)
        # expect(user).to receive(:update_attributes).with(params_to_permit).and_return(true)
        #
        # put :update, params: {id: user_params[:id], user: valid_attributes}

        # expect(user.active).to   eq(false)

      end
    end
  end
end
