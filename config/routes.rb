Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'recipes#public_recipes'
  # Defines the root path route ("/")
  resources :foods, expect: [:update]
  resources :recipes, expect: [:update]

  get '/public_recipes', to: 'recipes#public_recipes'
  get '/shopping_list', to: 'shopping_list#index'

  get '/toggle/:id', to: 'recipes#toggle'

  resources :recipes do
    resources :recipe_foods, only: %i[new create destroy]
  end
end
