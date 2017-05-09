Rails.application.routes.draw do

  get '', to: redirect('/login')
  get 'login', to: 'sessions#new', as: :login

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
