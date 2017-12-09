Rails.application.routes.draw do

  get 'errors/not_found'

  get 'errors/internal_server_error'

  resources :develloppeur_profiles, only: :show

  resources :projets, except: :destroy do
    resources :dones, only: :index
  end
  resources :client_profiles

 devise_for :users, :controllers => { registrations: 'registrations' }
  # devise_for :users
  # ATTENTION: Si bug routes avec DEVISE, voir ici <---
  get '/auth/:provider/callback', to: 'auth#create'

  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  ActiveAdmin.routes(self)

  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all
end
