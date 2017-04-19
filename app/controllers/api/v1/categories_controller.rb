class Api::V1::CategoriesController < ApplicationController
  before_action :authenticate_with_http_token, only: [:create, :update, :index, :destroy, :show]
  respond_to :json

  def index
    user = current_user
    render json: user.categories, root: "categories", adapter: :json, status: 200
  end

  def show
    user = current_user
    category = user.categories.where(id: params[:id]).first

    if category.present?
      render json: category, adapter: :json, status: 200
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
