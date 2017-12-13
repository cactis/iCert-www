Rails.application.routes.draw do

  resources :treeings
  resources :trees
  devise_for :users

  scope :path => "/api" do
    post "/subscribe", to: "courses#index"
    resources :courses do
      member do
        put "go"
      end
    end
    resources :certs do
      member do
        post 'confirm!', to: "certs#confirm!"
      end
    end
    resources :udollars
  end
end
