Rails.application.routes.draw do
  get 'users/show'
  resources :tasks, except: [:index] do
    resources :commits, only: [:create, :edit, :update, :destroy]
    resources :messages, only: [:create, :destroy]
    resources :permissions, only: [:create, :destroy]
  end
  root to: 'home#top'
  devise_for :users
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
end
