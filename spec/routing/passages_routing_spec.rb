describe PassagesController, type: :routing do
  describe 'routing' do

    it 'routes to #index' do
      expect(:get => '/passages').to route_to('passages#index')
    end

    it 'routes to #new' do
      expect(:get => '/passages/new').to route_to('passages#new')
    end

    it 'routes to #show' do
      expect(:get => '/passages/1').to route_to('passages#show', :id => '1')
    end

    it 'routes to #edit' do
      expect(:get => '/passages/1/edit').to route_to('passages#edit', :id => '1')
    end

    it 'routes to #create' do
      expect(:post => '/passages').to route_to('passages#create')
    end

    it 'routes to #update via PUT' do
      expect(:put => '/passages/1').to route_to('passages#update', :id => '1')
    end

    it 'routes to #update via PATCH' do
      expect(:patch => '/passages/1').to route_to('passages#update', :id => '1')
    end

    it 'routes to #destroy' do
      expect(:delete => '/passages/1').to route_to('passages#destroy', :id => '1')
    end

    it 'routes to #roll_out' do
      expect(:put => '/passages/1/roll_out').to route_to('passages#roll_out', :id => '1')
    end

    it 'routes to #close' do
      expect(:get => '/passages/1/close').to route_to('passages#close', :id => '1')
    end

    it 'routes to #passasges/drafts' do
      expect(:get => '/passages/drafts').to route_to('passages#drafts')
    end

    it 'routes to #passasges/ongoing' do
      expect(:get => '/passages/ongoing/').to route_to('passages#ongoing')
    end

    it 'routes to #passasges/ongoing with params' do
      expect(:get => '/passages/ongoing?query=something').to route_to('passages#ongoing', :query => 'something')
    end

    it 'routes to #passasges/finished' do
      expect(:get => '/passages/finished/').to route_to('passages#finished')
    end

    it 'routes to #passasges/finished with params' do
      expect(:get => '/passages/finished?query=something').to route_to('passages#finished', :query => 'something')
    end

  end
end
