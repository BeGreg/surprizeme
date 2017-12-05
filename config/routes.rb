Rails.application.routes.draw do

  devise_for :users
  resources :users do
    resources :ratings
  end

  resources :products
  resources :moments
  resources :surprises
  resources :location

  get '/styleguide', to: 'pages#styleguide'

  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
