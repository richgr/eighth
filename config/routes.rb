Eighth::Application.routes.draw do

  resources :sessions, :only => [ :new, :create, :destroy ]
  resources :microposts, :only => [ :create, :destroy ]
  resources :relationships, :only => [ :create, :destroy ]
  
  resources :users do
    member do
      get :following, :followers
    end
  end

  root :to => 'pages#home'

  match '/contact', :to => 'pages#contact'
  match '/about',   :to => 'pages#about'
  match '/help',    :to => 'pages#help'
  match '/signup',  :to => 'users#new'
  match '/signin',  :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy' 
  
end
