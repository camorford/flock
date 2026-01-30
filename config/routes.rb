Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token

  get "/auth/planning_center", to: "planning_center_auth#connect", as: :planning_center_connect
  get "/auth/planning_center/callback", to: "planning_center_auth#callback", as: :planning_center_callback

  namespace :admin do
    resources :teams do
      resources :positions, only: [:new, :create, :destroy]
    end
    resources :events do
      resources :assignments, only: [:new, :create, :destroy]
    end
    resource :import, only: [:show] do
      post :create_teams
      post :create_people
    end
  end

  namespace :volunteer do
    root "dashboard#index"
    resources :availabilities, only: [:index, :new, :create, :destroy]
    resources :assignments, only: [:index, :update]
  end

  get "up" => "rails/health#show", as: :rails_health_check

  root "admin/teams#index"
end