Rails.application.routes.draw do
  resources :artists
  resources :genres
  resources :songs
  post '/login', to: 'sessions#create'
  delete '/sessions/destroy', to: 'sessions#destroy'
  root 'welcome#index'
end
