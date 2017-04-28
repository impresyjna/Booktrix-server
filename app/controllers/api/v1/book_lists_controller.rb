class Api::V1::BookListsController < ApplicationController
  before_action :authenticate_with_http_token, only: [:create, :update, :index, :destroy]
  respond_to :json

  def index
    user = current_user
    book_lists = user.book_lists.where(book_list_state: params[:state_id])
    render json: book_lists, root: "book_lists", adapter: :json, status: 200
  end

  def create

  end

  def update

  end

  def destroy

  end

end
