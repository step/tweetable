describe UsersController, type: :routing do
  describe 'users routing' do

    it 'routes to #index' do
      expect(:get => '/users').to route_to('users#index')
    end

    it 'routes to #update via PUT' do
      expect(:put => '/users/1').to route_to('users#update', :id => '1')
    end

    it 'routes to #update via PATCH' do
      expect(:patch => '/users/1').to route_to('users#update', :id => '1')
    end

    it 'routes to #record' do
      expect(:get => '/users/record').to route_to('users#record')
    end
  end
end
