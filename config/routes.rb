Rails.application.routes.draw do
  root "static_pages#home"
  get 'history', to: 'static_pages#company_history', as: 'history'

  resources :contacts, only: [ :new, :create, :index ]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Almost every application defines a route for the root path ("/") at the top of this file.
  # root "articles#index"

  resources :employees, only: [ :index ]
  resources :skills, only: [ :index ]

  resources :zipcodes, only: :index

  resources :activities, only: [ :show ]

  # Errors pages 
  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all

end
