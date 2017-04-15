class Api::V1::UsersController < ApplicationController
  before_action :authenticate_with_http_token, only: [:update, :destroy, :add_friend]
  respond_to :json

  def show
    respond_with User.find(params[:id])
  end

  def create
    user = User.new(user_params)
    user_setting = UserSetting.create(user_setting_params)
    user.user_setting = user_setting
    if user.save
      render json: user, status: 201
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def update
    user = current_user

    if user.user_setting.update(user_setting_params) and user.update(user_params)
      render json: user, status: 200, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def destroy
    current_user.destroy
    head 204
  end

  def add_friend
    user = current_user
    friend = User.where(login: params[:friend]).first
    if user.login == params[:friend]
      render json: { errors: "Same logins" }, status: 422
    elsif !friend.present?
      head 404
    else
      user.friend_request(friend)
      render json: user.pending_friends, each_serializer: FriendSerializer, root: "friends", adapter: :json, status: 201, location: [:api, user]
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :login, :name, :surname)
  end

  def user_setting_params
    params.require(:user_setting).permit(:show_full_name, :show_gifts_boolean, :show_activities, :show_books)
  end

end