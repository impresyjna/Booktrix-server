Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: { format: :json }, path: '/api/' do
    scope module: :v1 do
      resources :users, :only => [:show, :create, :update, :destroy]
      resources :sessions, :only => [:create, :destroy]
      get 'found_by_isbn' => 'books#found_by_isbn'
      post 'add_friend' => 'users#add_friend'
    end
  end
end
