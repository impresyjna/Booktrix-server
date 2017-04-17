class Api::V1::FriendsController < ApplicationController
  before_action :authenticate_with_http_token, only: [:create, :update, :index]

  def index
    user = current_user
    case params[:list]
      when "index"
        render json: user.friends, each_serializer: FriendSerializer, root: "friends", adapter: :json, status: 200, location: [:api, user]
      when "pending"
        render json: user.pending_friends, each_serializer: FriendSerializer, root: "friends", adapter: :json, status: 200, location: [:api, user]
      when "requested"
        render json: user.requested_friends, each_serializer: FriendSerializer, root: "friends", adapter: :json, status: 200, location: [:api, user]
      when "blocked"
        render json: user.blocked_friends, each_serializer: FriendSerializer, root: "friends", adapter: :json, status: 200, location: [:api, user]
    end
  end

  def create
    user = current_user
    friend = User.where(login: params[:friend]).first
    if user.login == params[:friend]
      render json: { errors: "Same logins" }, status: 422
    elsif !friend.present?
      head 404
    else
      user.friend_request(friend)
      render json: user.pending_friends, each_serializer: FriendSerializer, root: "friends", adapter: :json, status: 201, location: [:api, user]
    end
  end

  def update

  end
end
