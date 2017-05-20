class Api::V1::UsersController < ApplicationController
  before_action :authenticate_with_http_token, only: [:update, :destroy, :add_friend]
  respond_to :json

  def show
    render json: User.find(params[:id]), adapter: :json, status: 200
  end

  def create
    user = User.new(user_params)
    user_setting = UserSetting.create(user_setting_params)
    user.user_setting = user_setting
    if user.save
      render json: user, adapter: :json, status: 201
    else
      render json: { errors: user.errors }, status: 409
    end
  end

  def update
    user = current_user

    if user.user_setting.update(user_setting_params) and user.update(user_params)
      render json: user, status: 200, adapter: :json, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def destroy
    current_user.destroy
    head 204
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :login, :name, :surname)
  end

  def user_setting_params
    params.require(:user_setting).permit(:show_full_name, :show_gifts_boolean, :show_activities, :show_books)
  end

end