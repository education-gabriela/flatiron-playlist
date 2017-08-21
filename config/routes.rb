Rails.application.routes.draw do

  resources :users, only: [:create, :new, :show, :edit, :update]
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/sessions/destroy', to: 'sessions#destroy'
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
