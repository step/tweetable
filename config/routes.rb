Rails.application.routes.draw do

  resources :passages
  resources :taggings
  resources :tags
  resources :responses
  resources :users, only: [:index, :show]
  get '', to: redirect('/login')
  get 'login', to: 'sessions#new', as: :login
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/passages/get_passage_by_status/:status', to: 'passages#get_passages_by_status'
  resources :passages do
    get 'roll_out', to: 'passages#roll_out'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
