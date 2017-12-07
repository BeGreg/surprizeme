Rails.application.routes.draw do

  devise_for :users
  resources :users

  resources :products do
    resources :ratings
  end
  resources :moments
  resources :surprises
  resources :location

  get "hot_or_not/", to: "ratings#hot_or_not"

  get '/styleguide', to: 'pages#styleguide'

  get 'search', to: 'products#search'
  root to: 'pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
