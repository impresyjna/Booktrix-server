require 'spec_helper'

RSpec.describe Api::V1::BorrowHistoriesController, type: :controller do
  describe "GET #index" do
    before(:each) do
      @user = FactoryGirl.create :user
      @friend = FactoryGirl.create :friend
      api_authorization_header @user.auth_token
      @book = FactoryGirl.create :book
      @user_book = UserBook.create(user_id: @user.id, book_id: @book.id)
      @borrow = Borrow.create(user_book_id: @user_book.id, user_id: @friend.id, state_id: 1)
      @borrow_history = BorrowHistory.create(user_book_id: @user_book.id, user_id: @friend.id, borrow_history_state_id: 1)
      get :index, user_book_id: @user_book.id
      borrow_history_response = json_response
      expect(borrow_history_response).to have_key(:borrow_history)
    end
    it { should respond_with 200 }
  end
end
