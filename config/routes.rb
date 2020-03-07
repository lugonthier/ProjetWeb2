Rails.application.routes.draw do
 
  
  
  
  resources :sports
 # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'categories/:slug', to: 'posts#categories', as: :categories_posts


  root to: 'pages#index'
  
  get '/profil', to: 'users#edit', as: :profil

  patch '/profil', to: 'users#update'

 

  get '/users', to: 'users#show'

  resources :sport_categories
  
  # Session à changer
  get '/login', to: 'sessions#new', as: :new_session
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: :destroy_session

  resources :sessions, only: [:new, :create, :destroy]

  resources :posts do
    collection do
      get 'me'
    end
  end

  
  
  resources :users, only: [:new, :create, :show] do
    member do
      get 'confirm'
    end
    resource :follows, only: [:create, :destroy]

    
    
  end

end
