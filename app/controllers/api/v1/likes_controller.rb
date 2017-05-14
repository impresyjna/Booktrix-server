class Api::V1::LikesController < ApplicationController
  before_action :authenticate_with_http_token, only: [:create, :destroy]
  respond_to :json

  def create
    user = current_user
    activity = Activity.find_by(id: params[:activity])
    if activity.present?
      like = Like.new(user_id: user.id, activity_id: activity.id)
      if like.save
        render json: {success: "Success"}, status: 201
      else
        render json: {errors: like.errors}, status: 422
      end
    else
      render json: {errors: "No activity"}, status: 404
    end

  end

  def destroy
    user = current_user
    like = Like.find_by(user_id: user.id, activity_id: params[:id])
    if like.present?
      like.destroy
      head 204
    else
      head 404
    end
  end
end
