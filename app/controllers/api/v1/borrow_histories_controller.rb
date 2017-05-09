class Api::V1::BorrowHistoriesController < ApplicationController
  before_action :authenticate_with_http_token, only: [:index]
  respond_to :json

  def index
    user = current_user
    user_book = user.user_books.where(id: params[:user_book_id])
    if user_book.present?
      binding.pry
      render json: user_book.borrow_histories, root: "borrow_histories", adapter: :json, status: 200
    else
      head 404
    end
  end

end
