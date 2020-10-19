Rails.application.routes.draw do
  resources :tasks, only: [:index]
  root to: 'home#top'
  devise_for :users
end
