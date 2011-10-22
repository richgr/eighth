Eighth::Application.routes.draw do

#  get "pages/home"
#  get "pages/contact"
#  get "pages/about"
#  get "pages/help"


  root :to => 'pages#home'

  match '/contact', :to => 'pages#contact'
  match '/about',   :to => 'pages#about'
  match '/help',    :to => 'pages#help'
  match '/signup',  :to => 'users#new'
end
