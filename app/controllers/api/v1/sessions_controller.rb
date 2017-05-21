class Api::V1::SessionsController < ApplicationController
  respond_to :json

  def create
    user_password = params[:session][:password]
    user_login = params[:session][:login]
    user = user_login.present? && User.find_by(login: user_login)

    if user.present? and user.valid_password? user_password
      sign_in user, store: false
      user.generate_authentication_token!
      user.save
      render json: user, status: 200, location: [:api, user]
    else
      render json: { errors: "Invalid email or password" }, status: 422
    end
  end

  def destroy
    user = User.find_by(auth_token: params[:id])
    user.generate_authentication_token!
    user.save
    head 204
  end

  private
  def session_params
    params.require(:session).permit(:login, :password)
  end

end