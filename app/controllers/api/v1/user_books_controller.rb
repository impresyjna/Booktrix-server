class Api::V1::UserBooksController < ApplicationController
  before_action :authenticate_with_http_token, only: [:create, :update, :index, :destroy]
  respond_to :json

  def index
    user = current_user
    user_books = user.user_books.where(borrowed: params[:borrowed] == "true" ? true : false)
    render json: user_books, root: "user_books",  adapter: :json, status: 200
  end

  def show
    user = current_user
    user_book = user.user_books.where(id: params[:id]).first
    if user_book.present?
      render json: user_book, root: "user_book", adapter: :json, status: 200
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
