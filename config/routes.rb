Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: { format: :json }, path: '/api/' do
    scope module: :v1 do
      resources :users, :only => [:show, :create, :update, :destroy]
      resources :sessions, :only => [:create, :destroy]
      get 'found_by_isbn' => 'books#found_by_isbn'
      get 'found_index' => 'books#found_index'
    end
  end
end
