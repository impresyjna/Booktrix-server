Rails.application.routes.draw do
  namespace :api, defaults: { format: :json }, path: '/api/' do
    scope module: :v1 do
      # We are going to list our resources here
    end
  end
end
