Rails.application.routes.draw do

  get '', to: redirect('/login')
  get 'login', to: 'sessions#new', as: :login
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'


  resources :passages do
    resources :responses

    collection do
      get 'drafts', to: 'passages#drafts'
      get 'ongoing', to: 'passages#ongoing'
      get 'finished', to: 'passages#finished'
      get 'commence_for_candidate', to: 'passages#commence_for_candidate'
      get 'missed_by_candidate', to: 'passages#missed_by_candidate'
      get 'attempted_by_candidate', to: 'passages#attempted_by_candidate'
    end

    member do
      put 'roll_out', to: 'passages#roll_out'
      get 'close', to: 'passages#close'
    end
  end
  resources :taggings
  resources :tags
end
