Rails.application.routes.draw do

  resources :treeings
  resources :trees
  devise_for :users

  scope :path => "/api" do
    post "/subscribe", to: "courses#index"
    resources :papers do
      member do
        Paper.aasm.events.each do |event|
          ev = event.name.to_s
          eval("post '" + ev + "!', to: '" + "papers#" + ev +"!'")
        end
      end
    end
    resources :courses do
      collection do
        post "reset"
      end
      member do
        put "go"
      end
    end
    resources :certs do
      resources :papers
      member do
        post 'confirm!', to: "certs#confirm!"
      end
    end
    resources :udollars
  end
end
