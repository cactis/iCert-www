Rails.application.routes.draw do

  resources :treeings
  resources :trees
  devise_for :users

  scope :path => "/api" do
    post "/subscribe", to: "courses#index"
    resources :courses
    resources :certs
    resources :udollars
  end
end
