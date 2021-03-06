Rails.application.routes.draw do
  get 'opinions/index'
  root "static_pages#home"

  resources :contacts, only: [ :new, :create, :index ]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Almost every application defines a route for the root path ("/") at the top of this file.
  # root "articles#index"

  resources :employees
  resources :skills

  resources :zipcodes, only: :index

  resources :activities, only: [ :index, :show, :edit, :update]

  scope controller: :static_pages do
    get :news
    get :achievements
    get :opinions
    get :about
    get :terms
    get :privacy
    get :history, to: 'static_pages#company_history', as: 'history'
    get 'kc-rc-yec-hed-mat', to: 'static_pages#dashboard', as: 'kc-rc-yec-hed-mat'
    end

  # sorcery
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  resources :users
  resources :sessions
  
  # Embed
  resource :embed, only: :update
  
  # Errors pages 
  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all

end
