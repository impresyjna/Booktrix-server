require 'spec_helper'

RSpec.describe Api::V1::ActivitiesController, type: :controller do
  describe "GET #index" do
    before(:each) do
      @user = FactoryGirl.create :user
      @friend = FactoryGirl.create :friend
      @user.friend_request(@friend)
      @friend.accept_request(@user)
      api_authorization_header @user.auth_token
      @book = FactoryGirl.create :book
      @mark = Mark.create(book_id: @book.id, user_id: @friend.id, value: 10, comment: "Text")
      @user_book = UserBook.create(user_id: @friend.id, book_id: @book.id)
      @book_activity = AddToLibraryActivity.create(book_id: @book.id, user_id: @friend.id)
      @friend_activity = FriendsActivity.create(user_id: @friend.id, friend_id: @user.id)
      @mark_activity = MarkActivity.create(user_id: @friend.id, book_id: @book.id, mark_id: @mark.id)
      get :index
      activities_response = json_response
      expect(activities_response).to have_key(:activities)
    end
    it { should respond_with 200 }
  end
end
