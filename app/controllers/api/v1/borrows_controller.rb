class Api::V1::BorrowsController < ApplicationController
  before_action :authenticate_with_http_token, only: [:create, :destroy]
  respond_to :json

  def create
    user = current_user
    case params[:borrow][:borrow_state]
      when BorrowHistoryState.states[:reserved]
        borrow = user.borrows.where(user_book_id: params[:borrow][:user_book_id]).first
        book_borrow = Borrow.where(user_book_id: params[:borrow][:user_book_id]).first
        if !borrow.present? and !book_borrow.present?
          borrow = Borrow.new(user_id: user.id, user_book_id: params[:borrow][:user_book_id], user_name: user.name, user_surname: user.surname, state_id: BorrowHistoryState.states[:reserved])
          #TODO: History of borrow here
          if borrow.save
            render json: {success: "Reserved"}, status: 201
          else
            render json: {errors: "Problem"}, status: 422
          end
        else
          render json: {errors: "Conflicted"}, status: 409
        end
      when BorrowHistoryState.states[:borrowed]
        book_title = UserBook.where(book_id: Book.where(title: params[:borrow][:title]).pluck(:id).first).first
        book_isbn = UserBook.where(book_id: Book.where(isbn: params[:borrow][:isbn]).pluck(:id).first).first
        book_id = UserBook.where(id: params[:borrow][:user_book_id]).first
        found_book = [book_title, book_isbn, book_id].uniq
        found_book = found_book.reject { |c| !c.present? }
        case found_book.count
          when 0
            render json: {errors: "No book to borrow"}, status: 422
          when 1
            @user_book = found_book.first
          else
            @user_book = found_book.select { |book| Book.find(book.book_id).title == params[:borrow][:title] }
        end

        if @user_book.present?
          @borrower = User.where(login: params[:borrow][:user_login]).first
          if @borrower.present?
            @borrow = Borrow.where(user_id: @borrower.id, user_book_id: @user_book.id).first
          end

          if !@borrow.present?
            @borrow = Borrow.new
          end

          #TODO: History of borrow here
          if @borrower.present?
            @borrow = @borrow.update(user_id: @borrower.id, user_book_id: @user_book.id, user_name: @borrower.name, user_surname: @borrower.surname, state_id: BorrowHistoryState.states[:borrowed])
          else
            @borrow = @borrow.update(user_id: nil, user_book_id: @user_book.id, user_name: params[:borrow][:user_name], user_surname: params[:borrow][:user_surname], state_id: BorrowHistoryState.states[:borrowed])
          end

          if @borrow
            render json: {success: "Success"}, status: 201
          else
            render json: {errors: @borrow.errors}, status: 422
          end
        end
      else
        render json: {errors: "Problem"}, status: 422
    end
  end

  def destroy

  end

  private

  def borrow_params
    params.require(:borrow).permit(:title, :isbn, :user_login, :user_name, :user_surname, :borrow_state)
  end

end
