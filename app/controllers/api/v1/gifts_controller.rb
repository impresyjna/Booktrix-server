class Api::V1::GiftsController < ApplicationController
  before_action :authenticate_with_http_token, only: [:create, :update, :index, :destroy, :show]
  respond_to :json

  def index
    user = current_user
    render json: user.gifts, root: "gifts", adapter: :json, status: 200
  end

  def show
    user = current_user
    gift = user.gifts.where(id: params[:id]).first

    if gift.present?
      render json: gift, adapter: :json, status: 200
    else
      head 404
    end
  end

  def create

  end

  def update

  end

  def destroy

  end
end
