Codemama::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :users

  resources :images

  root :to => 'images#index'
end
