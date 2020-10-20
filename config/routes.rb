Rails.application.routes.draw do
  resources :tasks
  root to: 'home#top'
  devise_for :users
end
