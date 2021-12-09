Rails.application.routes.draw do
  root "static_pages#home"

  resources :contacts, only: [ :new, :create, :index ]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Almost every application defines a route for the root path ("/") at the top of this file.
  # root "articles#index"
end
