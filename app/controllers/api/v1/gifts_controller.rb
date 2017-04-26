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
    user = current_user
    if !params[:gift][:title].present? and !params[:gift][:isbn].present?
      render json: { errors: "No title and isbn number" }, status: 422
    else
      book_title = Book.where(title: params[:gift][:title]).first
      book_isbn =  Book.where(isbn: params[:gift][:isbn]).first
      found_book = [book_title, book_isbn].uniq
      found_book =  found_book.reject { |c| c.nil? }
      @book = Book.new
      case found_book.count
        when 0
          @book = Book.create(title: params[:gift][:title], author: params[:gift][:author], isbn: params[:gift][:isbn])
        when 1
          @book = found_book.first
        else
          @book = found_book.select{ |book| book.title == params[:gift][:title] }
      end
      gift = user.gifts.build(book: @book)
      if gift.save
        render json: gift, adapter: :json, status: 201
      else
        render json: { errors: gift.errors }, status: 422
      end
    end
  end

  def update

  end

  def destroy

  end

  private

  def gift_params
    params.require(:gift).permit(:title, :author, :isbn)
  end
end
