Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: { format: :json }, path: '/api/' do
    scope module: :v1 do
      # We are going to list our resources here
    end
  end
end
