class Api::V1::UserBooksController < ApplicationController
  before_action :authenticate_with_http_token, only: [:create, :show, :update, :index, :destroy]
  respond_to :json

  def index
    user = current_user
    user_books = user.user_books.where(borrowed: params[:borrowed] == "true" ? true : false)
    render json: user_books, status: 200
  end

  def show
    user = current_user
    user_book = user.user_books.where(id: params[:id]).first
    if user_book.present?
      render json: user_book, status: 200
    else
      head 404
    end

  end

  def create
    user = current_user
    books = Book.where(title: params[:book][:title]).or(Book.where(isbn: params[:book][:isbn]))
    case books.count
      when 0
        @book = Book.create(book_params)
      when 1
        @book = books.first
      else
        if params[:book][:isbn].present?
          @book = books.where(isbn: params[:book][:isbn])
        else
          @book = books.first
        end
    end

    if @book.id.present?
    user_book = user.user_books.build(book_id: @book.id, category_id: params[:category])
    if user_book.save
      AddToLibraryActivity.create(user_id: user.id, book_id: @book.id)
      render json: user_book, status: 201
    else
      render json: { errors: user_book.errors }, status: 422
    end
    else
      render json: { errors: "Problem"}, status: 422
    end
  end

  def update
    user = current_user
    user_book = user.user_books.where(id: params[:id]).first
    if user_book.present?
      if user_book.book.update(book_params) and user_book.update(category_id: params[:category])
        render json: user_book, status: 200
      else
        render json: { errors: "Problem"}, status: 422
      end
    else
      head 422
    end
  end

  def destroy
    user = current_user
    user_book = user.user_books.where(id: params[:id]).first
    if user_book.present?
      user_book.destroy
      head 204
    else
      head 422
    end
  end

private

  def book_params
    params.require(:book).permit(:title, :author, :publisher, :isbn, :description, :page_count, :publisher_city)
  end
end
