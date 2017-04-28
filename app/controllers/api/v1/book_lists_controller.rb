class Api::V1::BookListsController < ApplicationController
  before_action :authenticate_with_http_token, only: [:create, :update, :index, :destroy]
  respond_to :json

  def index
    user = current_user
    book_lists = user.book_lists.where(book_list_state: params[:state_id])
    render json: book_lists, root: "book_lists", adapter: :json, status: 200
  end

  def create
    user = current_user
    book = Book.where(id: params[:book_list][:book_id]).first
    if book.present?
      book_list = user.book_lists.build(book_list_params)
      if book_list.save
        render json: {success: "Saved"}, status: 201
      else
        render json: {errors: "Cannot save"}, status: 422
      end
    else
      render json: {errors: "No book with this id"}, status: 422
    end
  end

  def update

  end

  def destroy

  end

  private

  def book_list_params
    params.require(:book_list).permit(:book_id, :book_list_state_id)
  end

end
