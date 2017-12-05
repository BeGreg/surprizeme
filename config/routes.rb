Rails.application.routes.draw do
  get 'surprises/index'

  get 'surprises/new'

  get 'surprises/show'

  get 'surprises/edit'

  get 'ratings/new'

  get 'ratings/edit'

  get 'locations/index'

  get 'locations/edit'

  get 'locations/new'

  get 'representations/new'

  get 'moments/new'

  get 'moments/show'

  get 'moments/edit'

  get 'moments/index'

  get 'suppliers/index'

  get 'suppliers/edit'

  get 'products/new'

  get 'products/show'

  get 'products/edit'

  get 'products/index'

  get 'users/new'

  get 'users/show'

  get 'users/edit'

  get 'users/index'

  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
