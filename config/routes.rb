Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'recipies#public_recipies'
  # Defines the root path route ("/")
  resources :foods, expect: [:update]
  resources :recipies, expect: [:update]
  # root "articles#index"
  get '/public_recipies', to: 'recipies#public_recipies'
end
