require 'openlibrary'

class Api::V1::BooksController < ApplicationController
  respond_to :json

  def found_index

  end

  def found_by_isbn
    client = Openlibrary::Client.new
    book = client.book('olid')
    respond_with book
  end

  private
  def book_params
    params.require(:book).permit(:title, :author, :publisher, :isbn, :image, :description, :publish_date, :page_count)
  end
end
