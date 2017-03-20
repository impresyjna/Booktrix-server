Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: { format: :json }, path: '/api/' do
    scope module: :v1 do
      resources :users, :only => [:show, :create, :update]
    end
  end
end
