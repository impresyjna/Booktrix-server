Rails.application.routes.draw do

  devise_for :users
  namespace :api, defaults: { format: :json }, path: '/api/' do
    scope module: :v1 do
      resources :users, :only => [:show, :create, :update, :destroy]
      resources :sessions, :only => [:create, :destroy]
      resources :friends, :only => [:index, :create]
      patch 'friends' => 'friends#update'
      delete 'friends' => 'friends#destroy'
      resources :categories, :only => [:index, :show, :create, :update, :destroy]
      resources :book_list_states, :only => [:index]
      resources :borrow_history_states, :only => [:index]
      resources :books, :only => [:index, :show]
      get 'found_by_isbn' => 'books#found_by_isbn'
      resources :request_to_fixes, :only => [:create]
      resources :gifts, :only => [:index, :show, :create, :destroy]
      resources :reservations, :only => [:index, :create, :destroy]
    end
  end
end
