class Api::V1::UserBooksController < ApplicationController
  before_action :authenticate_with_http_token, only: [:create, :update, :index, :destroy]
  respond_to :json

  def index

  end

  def show

  end

  def create

  end

  def update

  end

  def destroy

  end


end
