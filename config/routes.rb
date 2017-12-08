Rails.application.routes.draw do

  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :users

  resources :products do
    resources :ratings
  end
  resources :moments
  resources :surprises
  resources :location

  get '/surprise_details', to: 'surprises#surprise_details'

  get "/hot_or_not", to: "ratings#hot_or_not"

  get '/styleguide', to: 'pages#styleguide'

  post 'search', to: 'surprises#initiate_prod_cookie'

  root to: 'pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
