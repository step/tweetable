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

  describe 'POST #create_users' do
    context 'all emails are vaild' do

      it 'should create an active user with the given email' do
        user_params = {admin: true, id: 1, active: true}
        stub_current_user_with_attributes(user_params)
        email = 'something@email.com'
        user = double('user', email: email)

        expect(User).to receive(:new).with({email: email, active: true}).and_return user
        expect(user).to receive(:save).and_return true

        post :create_users, params: {emails: email}

        expect(flash[:success]).to match("Users something@email.com created successfully...")
      end

      it 'should create multiple active users with all the given emails' do
        user_params = {admin: true, id: 1, active: true}
        stub_current_user_with_attributes(user_params)
        email1 = 'something1@email.com'
        email2 = 'something2@email.com'
        user1 = double('user', email: email1)
        user2 = double('user', email: email2)

        expect(User).to receive(:new).with({email: email1, active: true}).and_return user1
        expect(User).to receive(:new).with({email: email2, active: true}).and_return user2
        expect(user1).to receive(:save).and_return true
        expect(user2).to receive(:save).and_return true

        post :create_users, params: {emails: [email1, email2].join(',')}

        expect(flash[:success]).to match("Users something1@email.com, something2@email.com created successfully...")
      end

    end

    context 'some emails are invalid' do
      it 'should not create multiple active users with if given emails are invalid' do
        user_params = {admin: true, id: 1, active: true}
        stub_current_user_with_attributes(user_params)
        email1 = 'something@email.com'
        email2 = 'something@email.com'
        user1 = double('user', email: email1)
        user2 = double('user', email: email2)

        expect(User).to receive(:new).with({email: email1, active: true}).and_return user1
        expect(User).to receive(:new).with({email: email2, active: true}).and_return user2
        expect(user1).to receive(:save).and_return true
        expect(user2).to receive(:save).and_return false

        post :create_users, params: {emails: [email1, email2].join(',')}

        expect(flash[:success]).to match("Users something@email.com created successfully...")
        expect(flash[:danger]).to match("Users something@email.com failed to create...")
      end


      it 'should create active users for the valid email and should not for invalid one' do
        user_params = {admin: true, id: 1, active: true}
        stub_current_user_with_attributes(user_params)
        email1 = 'something@email.com'
        email2 = 'something@email.com'
        email3 = 'something2@email.com'
        user1 = double('user', email: email1)
        user2 = double('user', email: email2)
        user3 = double('user', email: email3)

        expect(User).to receive(:new).with({email: email1, active: true}).and_return user1
        expect(User).to receive(:new).with({email: email2, active: true}).and_return user2
        expect(User).to receive(:new).with({email: email3, active: true}).and_return user3
        expect(user1).to receive(:save).and_return true
        expect(user2).to receive(:save).and_return false
        expect(user3).to receive(:save).and_return true

        post :create_users, params: {emails: [email1, email2, email3].join(',')}

        expect(flash[:success]).to match("Users something@email.com, something2@email.com created successfully...")
        expect(flash[:danger]).to match("Users something@email.com failed to create...")
      end
    end

  end
end
