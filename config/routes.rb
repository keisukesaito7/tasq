Rails.application.routes.draw do
  resources :tasks, except: [:index] do
    resources :commits, only: [:create, :edit, :update, :destroy] do
      resources :likes, only: [:create]
    end
    resources :messages, only: [:create, :destroy]
    resources :permissions, only: [:create, :destroy]
  end
  delete 'tasks/:task_id/permissions_reviewer', to: 'permissions#reviewer_destroy', as: 'reviewer_permission_destroy'
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/guest_sessions#new_guest'
    post 'users/guest_beta_sign_in', to: 'users/guest_sessions#new_guest_beta'
  end
  get 'users/:id/profile', to: 'users#show', as: 'user_profile'
  root to: 'home#top'
end
