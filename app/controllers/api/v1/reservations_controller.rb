class Api::V1::ReservationsController < ApplicationController
  before_action :authenticate_with_http_token, only: [:create, :index, :destroy]
  respond_to :json

  def index
    user = current_user
    reservations = user.reservations
    render json: reservations, root: "reservations", adapter: :json, status: 200
  end

  def create
    user = current_user
    gift = Gift.where(id: params[:reservation][:gift_id]).first

    if gift.present? and user.friends.include?(gift.user)
      reservation = user.reservations.build(gift_id: gift.id)
      if reservation.save
        render json: reservation, adapter: :json, status: 201
      else
        render json: {errors: reservation.errors}, status: 422
      end
    else
      render json: {errors: "No gift with this id"}, status: 422
    end
  end

  def destroy
    user = current_user
    reservation = user.reservations.where(id: params[:id]).first
    if reservation.present?
      reservation.destroy
      head 204
    else
      head 422
    end
  end

end
