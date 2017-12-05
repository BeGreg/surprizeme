Rails.application.routes.draw do

  resources :users do
    resources :ratings
  end

  resources :products
  resources :moments
  resources :surprises
  resources :location

  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
