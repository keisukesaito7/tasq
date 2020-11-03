Rails.application.routes.draw do
  resources :tasks, except: [:index] do
    resources :commits, only: [:create, :edit, :update, :destroy]
    resources :messages, only: [:create, :destroy]
    resources :permissions, only: [:create, :destroy]
  end
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/test_sessions#new_guest'
  end
  get 'users/:id/profile', to: 'users#show', as: 'user_profile'
  root to: 'home#top'
end
