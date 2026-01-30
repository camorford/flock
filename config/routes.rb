Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token

  namespace :admin do
    resources :teams do
      resources :positions, only: [:new, :create, :destroy]
    end
    resources :events do
      resources :assignments, only: [:new, :create, :destroy]
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check

  root "admin/teams#index"
end