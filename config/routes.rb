Rails.application.routes.draw do
  resources :artists, except: [:destroy]
  resources :genres, except: [:destroy]
  resources :songs, except: [:destroy]
  resources :users, except: [:destroy, :index]
  resources :playlists
  post '/login', to: 'sessions#create'
  delete '/sessions/destroy', to: 'sessions#destroy'
  root 'welcome#index'
end
