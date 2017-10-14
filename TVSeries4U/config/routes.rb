Rails.application.routes.draw do
  root 'static_pages#home'

  get '/home', to: 'static_pages#home'
  get '/contact', to: 'static_pages#contact'

  ##sesiones
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/signup', to: 'users#new'

  # Series, capitulos y reviews
  resources :series do
    resources :seasons do
      resources :chapters do
        resources :chapters_reviews

        resources :seens, only: [:create, :destroy]
      end
      
      resources :seasons_reviews
    end

    resources :series_news
    resources :sreviews
  end
  resources :perfilseries,        only: [:create, :destroy]

  # Users
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships,       only: [:create, :destroy]

  # Families
  resources :families do
    resources :family_invites
    resources :family_members
  end
  
  # Series fill
  resources :genres
  resources :genres_relationships,       only: [:create, :destroy]

  resources :actors do
    resources :actors_news
  end
  resources :actors_relationships,       only: [:create, :destroy]

  resources :directors do
    resources :directors_news
  end
  resources :directors_relationships,       only: [:create, :destroy]

  resources :news_feed,           only: [:index]
end
