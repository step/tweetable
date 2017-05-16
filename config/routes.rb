Rails.application.routes.draw do

  get '', to: redirect('/login')
  get 'login', to: 'sessions#new', as: :login
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :users, only: [:index, :show]

  resources :passages do
    collection do
      get 'drafts', to: 'passages#drafts'
      get 'opened', to: 'passages#opened'
      get 'closed', to: 'passages#closed'
      get 'open_for_candidate', to: 'passages#open_for_candidate'
    end

    member do
      get 'roll_out', to: 'passages#roll_out'
      get 'close', to: 'passages#close'
    end
  end

  resources :taggings
  resources :tags
  resources :responses

  # get '/passages/drafts', to: 'passages#drafts'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
