Rails.application.routes.draw do

  resources :develloppeur_profiles, only: :show


  resources :projets, except: :destroy do
    resources :messages, except: :show
    resources :dones, only: :index
  end

  resources :client_profiles
  resources :projets, except: :destroy

  devise_for :users, :controllers => { registrations: 'registrations' }

  # devise_for :users
  # ATTENTION: Si bug routes avec DEVISE, voir ici <---
  get '/auth/:provider/callback', to: 'auth#create'

  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  ActiveAdmin.routes(self)
end
