Rails.application.routes.draw do

  resources :taggings
  resources :tags
  resources :responses
  resources :users, only: [:index, :show]
  get '', to: redirect('/login')
  get 'login', to: 'sessions#new', as: :login
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  resources :passages

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
