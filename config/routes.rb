Rails.application.routes.draw do
  root to: "projects#index"

  devise_for :users
  resources :projects do
    resources :project_activities, only: [:create]
  end
end
