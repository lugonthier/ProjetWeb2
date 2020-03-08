Rails.application.routes.draw do
 
  
  
  
  resources :sports
 # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'categories/:slug', to: 'sports#categories', as: :categories_sports


  root to: 'pages#index'
  
  get '/profil', to: 'users#edit', as: :profil

  patch '/profil', to: 'users#update'

 
  
  #get '/users', to: 'users#show'

  
  scope 'superadmin', module: 'admin', as: 'admin' do
    resources :sport_categories
    resources :users
    resources :sports
    resources :posts
  end

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

  
  
  resources :users, only: [:new, :create, :show, :index, :destroy] do
    member do
      get 'confirm'
    end
   
    resource :follows, only: [:create, :destroy, :show]

    
    
  end

end
