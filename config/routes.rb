Rails.application.routes.draw do
  resources :tasks, only: [:index, :new, :create, :show, :edit, :update]
  root to: 'home#top'
  devise_for :users
end
