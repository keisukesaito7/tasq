Rails.application.routes.draw do
  resources :tasks, except: [:index] do
    resources :commits, only: [:create, :edit, :update, :destroy]
    resources :messages, only: [:create]
    resources :permissions, only: [:create]
  end
  root to: 'home#top'
  devise_for :users
end
