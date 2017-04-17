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
        expect(friend_response).to have_key(:friends)
      end
      it { should respond_with 200 }
    end

    context "get pending friends" do
      before(:each) do
        get :index, {list: "pending"}
        friend_response = json_response
        expect(friend_response).to have_key(:friends)
      end
      it { should respond_with 200 }
    end

    context "get requested friends" do
      before(:each) do
        get :index, {list: "requested"}
        friend_response = json_response
        expect(friend_response).to have_key(:friends)
      end
      it { should respond_with 200 }
    end

    context "get blocked friends" do
      before(:each) do
        get :index, {list: "blocked"}
        friend_response = json_response
        expect(friend_response).to have_key(:friends)
      end
      it { should respond_with 200 }
    end

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
        expect(friend_response).to have_key(:friends)
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

  end

  describe "DELETE destroy" do

  end
end
