Rails.application.routes.draw do
  get 'contacts/index'
  root 'chats#index'

  get 'sign_up', to: 'registrations#new'
  post 'sign_up', to: 'registrations#create'

  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create', as: 'log_in'
  delete 'logout', to: "sessions#destroy"

  resources :user_profiles
  resources :contacts

  namespace :api do
    namespace :v1 do
      resources :contacts
      resources :messages

      get 'messages/users/:id', to: 'messages#show'
    end
  end
end
