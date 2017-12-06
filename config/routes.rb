Rails.application.routes.draw do
  get 'clients/index'

  get 'clients/show'

  get 'clients/new'

  get 'clients/create'

  get 'clients/edit'

  get 'clients/update'

  get 'clients/destroy'

  get 'developpeurs/index'

  get 'developpeurs/show'

  get 'developpeurs/new'

  get 'developpeurs/create'

  get 'developpeurs/edit'

  get 'developpeurs/update'

  get 'developpeurs/destroy'

  resources :projets, except: :destroy

  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { registrations: 'registrations' }
  # devise_for :users
  # ATTENTION: Si bug routes avec DEVISE, voir ici <---
  get '/auth/:provider/callback', to: 'auth#create'

  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
