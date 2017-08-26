# frozen_string_literal: true

Rails.application.routes.draw do
  get '', to: redirect('/login')
  get 'login', to: 'sessions#new', as: :login
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/clearance', to: 'application#clearance', as: :clearance

  resources :users do
    collection do
      post 'create_users', to: 'users#create_users'
      get 'passage', to: 'users#filter_users', as: :filter
    end
  end

  resources :leader_board, only: [:index]

  resources :manual, only: [:index]

  resources :responses do
    resources :taggings do
      collection do
        post 'create_tagging_by_tag_name', to: 'taggings#create_tagging_by_tag_name'
        delete 'delete_tagging_by_tag_name', to: 'taggings#delete_tagging_by_tag_name'
        put 'review_taggings', to: 'taggings#review_taggings'
      end
    end
  end

  resources :passages do
    resources :responses

    collection do
      get 'drafts', to: 'passages#drafts'
      get 'ongoing', to: 'passages#ongoing'
      get 'concluded', to: 'passages#concluded'
      get 'commenced', to: 'passages#commenced'
      get 'missed', to: 'passages#missed'
      get 'attempted', to: 'passages#attempted'
    end

    member do
      put 'commence', to: 'passages#commence'
      get 'conclude', to: 'passages#conclude'
    end
  end

  resources :tags, except: [:edit, :show]

  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all
end
