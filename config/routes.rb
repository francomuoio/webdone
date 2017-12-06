Rails.application.routes.draw do
  resources :projets, except: :destroy

  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { registrations: 'registrations' }
  # devise_for :users
  # ATTENTION: Si bug routes avec DEVISE, voir ici <---
  get '/auth/:provider/callback', to: 'auth#create'

  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
