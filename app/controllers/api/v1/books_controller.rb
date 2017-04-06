class Api::V1::BooksController < ApplicationController
  respond_to :json

  def found_index

  end

  def found_by_isbn
    book_service = Google::Apis::BooksV1::BooksService
    book = book_service.volumes.get()
  end

  private
  def book_params
    params.require(:book).permit(:title, :author, :publisher, :isbn, :image, :description, :publish_date, :page_count)
  end
end
