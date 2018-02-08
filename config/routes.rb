Rails.application.routes.draw do

  resources :course_user_subjects
  resources :course_subjects
  resources :subjects
  resources :course_users
  resources :course_templates
  resources :templates
  resources :themes do
    # get 'new', to: 'themes#new', on: :collection
    # get 'edit', to: 'themes#edit'
  end
  resources :assets
  resources :certs do
    member do
      get :validates, to: "certs#show"
    end
  end
  resources :treeings
  resources :trees
  devise_for :users

  scope :path => "/api" do

    resources :templates
    resources :cert_details do
      resources :templates
    end
    resources :cert_apply_details
    resources :cert_applies
    resources :cert_details
    post "/subscribe", to: "courses#index"
    resources :papers do
      member do
        post 'pay_by_code!', to: 'papers#pay_by_code!'
        get 'qrcode', to: 'papers#qrcode'
        get 'download', to: 'papers#download'
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
      get 'demo', to: 'certs#demo', on: :collection
      member do
        get 'new', to: "certsnew"
        post 'confirm!', to: "certs#confirm!"
        get 'qrcode', to: "certs#qrcode"
        get 'paper', to: 'certs/paper'
        get 'html', to: 'certs/html'
      end
      resources :papers do
        # member do
        get 'new', to: 'papers#new', on: :collection
      end
    end
    resources :udollars
  end
end
