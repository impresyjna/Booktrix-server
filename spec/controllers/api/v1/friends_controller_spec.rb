require 'spec_helper'

RSpec.describe Api::V1::FriendsController, type: :controller do
  describe "GET #index" do
    before(:each) do
      @user = FactoryGirl.create :user
      api_authorization_header @user.auth_token
    end

    context "get friends" do
      before(:each) do
        get :index, {list: "index"}
        friend_response = json_response
      end
      it { should respond_with 200 }
    end

    context "get pending friends" do
      before(:each) do
        get :index, {list: "pending"}
        friend_response = json_response
      end
      it { should respond_with 200 }
    end

    context "get requested friends" do
      before(:each) do
        get :index, {list: "requested"}
        friend_response = json_response
      end
      it { should respond_with 200 }
    end

    context "get blocked friends" do
      before(:each) do
        get :index, {list: "blocked"}
        friend_response = json_response
      end
      it { should respond_with 200 }
    end
  end

  describe "GET #show" do
    before(:each) do
      @user = FactoryGirl.create :user
      @friend = FactoryGirl.create :friend
      @friend.friend_request(@user)
      @user.accept_request(@friend)
      @book = Book.create(title: "Aaa", author: "aaa", isbn: "1234567890123")
      @user_book = UserBook.create(book_id: @book.id, user_id: @friend.id)
      @gift = FactoryGirl.create :gift
      @gift.user_id = @friend.id
      @gift.save
      api_authorization_header @user.auth_token
      get :show, id: @friend.id
    end

    it "returns the information about a reporter on a hash" do
      friend_response = json_response
      expect(friend_response[:login]).to eql @friend.login
    end

    it { should respond_with 200 }

  end

  describe "POST #create" do
    before(:each) do
      @user = FactoryGirl.create :user
      api_authorization_header @user.auth_token
    end

    context "when is successfully created" do
      before(:each) do
        @friend = FactoryGirl.create :friend
        post :create, {friend: @friend.login}
        friend_response = json_response
      end
      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        post :create, {friend: @user.login}
        friend_response = json_response
        expect(friend_response).to have_key(:errors)
      end

      it { should respond_with 422 }
    end

    context "when friend not found" do
      before(:each) do
        @friend = FactoryGirl.create :friend
        @friend.login = "login2"
        post :create, {friend: @friend.login}
      end

      it { should respond_with 404 }
    end
  end

  describe "PUT/PATCH #update" do
    before(:each) do
      @user = FactoryGirl.create :user
      @friend = FactoryGirl.create :friend
      @friend.friend_request(@user)
      api_authorization_header @user.auth_token
    end

    context "when friend accepted" do

      before(:each) do
        patch :update, {login: @friend.login, friend_action: "accept"}
        friend_response = json_response
        expect(friend_response).to have_key(:success)
      end

      it { should respond_with 200 }
    end

    context "when friend not in list to accept" do

      before(:each) do
        patch :update, {login: "login2", friend_action: "accept"}
        friend_response = json_response
        expect(friend_response).to have_key(:errors)
      end

      it { should respond_with 422 }
    end

    context "when friend blocked" do
      before(:each) do
        patch :update, {login: @friend.login, friend_action: "block"}
        friend_response = json_response
        expect(friend_response).to have_key(:blocked)
      end

      it { should respond_with 200 }
    end

    context "when friend to block not in the list" do
      before(:each) do
        patch :update, {login: "login2", friend_action: "block"}
        friend_response = json_response
        expect(friend_response).to have_key(:errors)
      end

      it { should respond_with 422 }
    end

  end

  describe "DELETE destroy" do
    before(:each) do
      @user = FactoryGirl.create :user
      @friend = FactoryGirl.create :friend
      @user.friend_request(@friend)
      @friend.accept_request(@user)
      api_authorization_header @user.auth_token
    end

    context "when friend unblocked" do
      before(:each) do
        @user.block_friend(@friend)
        delete :destroy, {login: @friend.login, friend_action: "unblock"}
      end

      it { should respond_with 204}
    end

    context "when friend cannot be unblocked" do
      before(:each) do
        delete :destroy, {login: "login2", friend_action: "unblock"}
        friend_response = json_response
        expect(friend_response).to have_key(:errors)
      end

      it { should respond_with 422}
    end

    context "when friend removed" do
      before(:each) do
        delete :destroy, {login: @friend.login, friend_action: "remove"}
      end

      it { should respond_with 204}
    end

    context "when friend cannot be unblocked" do
      before(:each) do
        delete :destroy, {login: "login2", friend_action: "remove"}
        friend_response = json_response
        expect(friend_response).to have_key(:errors)
      end

      it { should respond_with 422}
    end

  end
end
