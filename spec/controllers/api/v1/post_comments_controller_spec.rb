require 'spec_helper'

RSpec.describe Api::V1::PostCommentsController, type: :controller do
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
      @post_comment = PostComment.create(user_id: @user.id, activity_id: @book_activity.id, content: "Hello")
      get :index, activity: @book_activity.id
      post_comments_response = json_response
      expect(post_comments_response).to have_key(:post_comments)
    end
    it { should respond_with 200 }
  end

  describe "POST #create" do
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
    end

    context "when is successfully created" do
      before(:each) do
        @post_comment_attributes = {activity_id: @book_activity.id, content: "Hello"}
        post :create, {post_comment: @post_comment_attributes}
      end

      it "renders the json representation for the user record just created" do
        post_comments_response = json_response
        expect(post_comments_response).to have_key(:post_comments)
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        @book_activity = AddToLibraryActivity.create(book_id: @book.id, user_id: @friend.id)
        @invalid_post_comment_attributes = {activity_id: @book_activity.id, content: ""}
        post :create, {post_comment: @invalid_post_comment_attributes}
      end

      it "renders an errors json" do
        post_comments_response = json_response
        expect(post_comments_response).to have_key(:errors)
      end

      it { should respond_with 422 }
    end

    context "when is no activity created" do
      before(:each) do
        @book_activity.destroy
        @post_comment_attributes = {activity_id: @book_activity.id, content: "Hello"}
        post :create, {post_comment: @post_comment_attributes}
      end

      it "renders an errors json" do
        post_comments_response = json_response
        expect(post_comments_response).to have_key(:errors)
      end

      it { should respond_with 404 }
    end
  end

  describe "PUT/PATCH #update" do
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
      @post_comment = PostComment.create(user_id: @user.id, activity_id: @book_activity.id, content: "Hello")
    end

    context "when is successfully updated" do
      before(:each) do
        patch :update, {id: @post_comment.id, post_comment: {activity_id: @book_activity.id, content: "Hello2"}}
      end

      it "renders the json representation for the updated user" do
        post_comments_response = json_response
        expect(post_comments_response).to have_key(:post_comments)
      end

      it { should respond_with 200 }
    end

    context "when is not updated" do
      before(:each) do
        patch :update, {id: @post_comment.id, post_comment: {activity_id: @book_activity.id, content: ""}}
      end

      it "renders an errors json" do
        post_comments_response = json_response
        expect(post_comments_response).to have_key(:errors)
      end

      it { should respond_with 422 }
    end

    context "when update is impossible - category doesn't exist" do
      before(:each) do
        @book_activity.destroy
        patch :update, {id: @post_comment.id, post_comment: {activity_id: @book_activity.id, content: "Hello2"}}
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
      @post_comment = PostComment.create(user_id: @user.id, activity_id: @book_activity.id, content: "Hello")
    end

    context "when delete success" do
      before(:each) do
        delete :destroy, {id: @post_comment.id}
      end

      it { should respond_with 204 }
    end

    context "when cannot delete - post_comment doesn't exists" do
      before(:each) do
        @book_activity.destroy
        delete :destroy, {id: @post_comment.id}
      end

      it { should respond_with 404 }
    end

  end
end
