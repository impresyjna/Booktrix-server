class Api::V1::ActivitiesController < ApplicationController
  before_action :authenticate_with_http_token, only: [:update, :destroy, :add_friend]
  respond_to :json

  def index
    user = current_user
    friends = user.friends.pluck(:id)
    activities = Activity.where(user_id: friends).last(100)
    render json: activities, root: "activities", adapter: :json, status: 200
  end
end
