require 'spec_helper'

RSpec.describe Api::V1::LikesController, type: :controller do
  describe "POST #create" do
    before(:each) do
      @user = FactoryGirl.create :user
      @friend = FactoryGirl.create :friend
      @user.friend_request(@friend)
      @friend.accept_request(@user)
      api_authorization_header @user.auth_token
      @book = FactoryGirl.create :book
      @user_book = UserBook.create(user_id: @friend.id, book_id: @book.id)
      @book_activity = AddToLibraryActivity.create(book_id: @book.id, user_id: @friend.id)
    end

    context "when is successfully created" do
      before(:each) do
        post :create, {activity: @book_activity.id}
      end

      it "renders the json representation for the user record just created" do
        like_response = json_response
        expect(like_response).to have_key(:success)
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        @book_activity.destroy
        post :create, {activity: @book_activity.id}
      end

      it "renders an errors json" do
        like_response = json_response
        expect(like_response).to have_key(:errors)
      end

      it { should respond_with 404 }
    end
  end

  describe "DELETE #destroy" do
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
      @like = Like.create(user_id: @user.id, activity_id: @book_activity.id)
    end

    context "when delete success" do
      before(:each) do
        delete :destroy, {id: @book_activity.id}
      end

      it { should respond_with 204 }
    end

    context "when cannot delete - activity doesn't exists" do
      before(:each) do
        @book_activity.destroy
        delete :destroy, {id: @book_activity.id}
      end

      it { should respond_with 404 }
    end

  end
end
