Codemama::Application.routes.draw do
  get "home/index"

    resources :edms do
        member do
            get 'clone'
            get 'preview'
            get 'edit_content'
            get 'download'
            put 'switch_locked'
        end
    end

    resources :edm_templates do
        member do
            get 'preview'
        end
        resources :edms
    end

    resources :faqs

    resources :pictures

    ActiveAdmin.routes(self)

    devise_for :users

    match "/pictures/upload" => "pictures#upload"
    match "/pictures/uploadBase64" => "pictures#uploadBase64"

    root :to => "home#index"
end
