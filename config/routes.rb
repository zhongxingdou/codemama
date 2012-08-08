Codemama::Application.routes.draw do
  resources :pictures

  ActiveAdmin.routes(self)

  devise_for :users

  #root :to => 'pictures#index'

  match '/pictures/index' => 'pictures#index', :as => :user_root

end
