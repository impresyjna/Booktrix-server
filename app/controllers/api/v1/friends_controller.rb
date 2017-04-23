class Api::V1::FriendsController < ApplicationController
  before_action :authenticate_with_http_token, only: [:create, :update, :index, :destroy]

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
      else
        render json: {errors: "Request error"}, status: 422
    end
  end

  #TODO: Show friend

  def create
    user = current_user
    friend = User.where(login: params[:friend]).first
    if user.login == params[:friend]
      render json: {errors: "Same logins"}, status: 422
    elsif !friend.present?
      head 404
    else
      user.friend_request(friend)
      render json: user.pending_friends, each_serializer: FriendSerializer, root: "friends", adapter: :json, status: 201, location: [:api, user]
    end
  end

  def update
    user = current_user
    case params[:friend_action]
      when "accept"
        friend = user.requested_friends.select { |user| user.login == params[:login] }.first
        if user.login == params[:friend] || !friend.present?
          render json: {errors: "Cannot accept this request"}, status: 422
        else
          user.accept_request(friend)
          render json: {success: "Friend accepted"}, status: 200
        end
      when "block"
        friends_lists = user.requested_friends + user.friends
        friend = friends_lists.select { |user| user.login == params[:login] }.first
        if user.login == params[:friend] || !friend.present?
          render json: {errors: "Cannot block this friend"}, status: 422
        else
          user.block_friend(friend)
          render json: {blocked: "Blocked this user"}, status: 200
        end
      else
        render json: {errors: "Request error"}, status: 422
    end
  end

  def destroy
    user = current_user
    case params[:friend_action]
      when "unblock"
        friend = user.blocked_friends.select { |user| user.login == params[:login] }.first
        if user.login == params[:friend] || !friend.present?
          render json: {errors: "Cannot accept this request"}, status: 422
        else
          user.unblock_friend(friend)
          render json: {success: "Friend unblocked"}, status: 204
        end
      when "remove"
        friends_lists =  user.friends + user.blocked_friends
        friend = friends_lists.select { |user| user.login == params[:login] }.first
        if user.login == params[:friend] || !friend.present?
          render json: {errors: "Cannot block this friend"}, status: 422
        else
          user.remove_friend(friend)
          render json: {blocked: "Removed this user"}, status: 204
        end
      else
        render json: {errors: "Request error"}, status: 422
    end

  end
end
