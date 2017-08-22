Rails.application.routes.draw do
  resources :artists, except: [:destroy]
  resources :genres, except: [:destroy]
  resources :songs, except: [:destroy]
  resources :users, except: [:destroy]

  post '/playlist/songs', to: 'playlists#add_songs', as: :add_songs_to_playlist
  delete '/playlist/:id/songs', to: 'playlists#delete_songs', as: :delete_songs_from_playlist

  resources :playlists
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/sessions/destroy', to: 'sessions#destroy'
  root 'welcome#index'
  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :playlists do
    member do
      get :likes
    end
  end

  resources :relationships, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
  get '/auth/facebook/callback' => 'sessions#create'

  post '/search', to: 'songs#search'
  get '/search', to: 'songs#search'
end
