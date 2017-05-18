describe UsersController, type: :controller do

  let(:valid_attributes) {
    {name:'valid_user',auth_id:'auth_id'}
  }

  before(:each) do
    @user = User.create! valid_attributes
    controller.session[:user_id] = @user.auth_id
  end

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: {id: @user.to_param}
      expect(response).to be_success
    end
  end
end
