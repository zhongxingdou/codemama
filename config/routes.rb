Codemama::Application.routes.draw do
  resources :faqs

  resources :pictures

  ActiveAdmin.routes(self)

  devise_for :users

  match "/pictures/upload" => "pictures#upload"

  root :to => "pictures#index"
end
