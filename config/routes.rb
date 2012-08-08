Codemama::Application.routes.draw do
  resources :pictures

  ActiveAdmin.routes(self)

  devise_for :users

  root :to => "pictures#index"
end
