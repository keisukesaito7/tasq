Rails.application.routes.draw do
  resources :tasks, except: [:index] do
    resources :commits, only: [:new, :create, :edit, :update, :destroy]
    resources :messages, only: [:create]
  end
  root to: 'home#top'
  devise_for :users
end
