class Api::V1::ReservationsController < ApplicationController
  before_action :authenticate_with_http_token, only: [:create, :index, :destroy]
  respond_to :json

  def index
    user = current_user
    reservations = user.reservations
    render json: reservations, root: "reservations", adapter: :json, status: 200
  end

  def create

  end

  def destroy

  end

end
