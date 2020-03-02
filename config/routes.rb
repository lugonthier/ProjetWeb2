Rails.application.routes.draw do
 
  
  resources :posts
 # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  root to: 'users#new'
  
  get '/profil', to: 'users#edit', as: :profil
  patch '/profil', to: 'users#update'


  # Session
  get '/login', to: 'sessions#new', as: :new_session
  post 'login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: :destroy_session

  resources :sessions, only: [:new, :create, :destroy]
  resources :sports
  resources :users, only: [:new, :create] do
    member do
      get 'confirm'
    end
  end

end
