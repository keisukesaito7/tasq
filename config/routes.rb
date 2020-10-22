Rails.application.routes.draw do
  resources :tasks do
    resources :commits, only: [:new, :create, :edit, :update, :destroy]
    resources :messages, only: [:new, :create]
  end
  root to: 'home#top'
  devise_for :users
end
