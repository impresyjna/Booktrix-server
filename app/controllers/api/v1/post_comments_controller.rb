class Api::V1::PostCommentsController < ApplicationController
  before_action :authenticate_with_http_token, only: [:create, :index, :destroy, :update]
  respond_to :json

  def index
    activity = Activity.find_by(id: params[:activity])
    if activity.present?
      post_comments = activity.post_comments
      render json: post_comments, each_serializer: PostCommentSerializer, root: "post_comments", adapter: :json, status: 200
    else
      head 404
    end
  end

  def create
    user = current_user
    activity = Activity.find_by(id: params[:post_comment][:activity_id])
    if activity.present?
      post_comment = user.post_comments.build(post_comment_params)
      if post_comment.save
        post_comments = activity.post_comments
        render json: post_comments, each_serializer: PostCommentSerializer, root: "post_comments", adapter: :json, status: 201
      else
        render json: {errors: post_comment.errors}, status: 422
      end
    else
      render json: {errors: "No activity"}, status: 404
    end
  end

  def update
    user = current_user
    activity = Activity.find_by(id: params[:post_comment][:activity_id])
    post_comment = user.post_comments.find_by(id: params[:id])
    if activity.present?
      if post_comment.present?
        if post_comment.update(post_comment_params)
          post_comments = activity.post_comments
          render json: post_comments, each_serializer: PostCommentSerializer, root: "post_comments", adapter: :json, status: 200
        else
          render json: {errors: post_comment.errors}, status: 422
        end
      else
        render json: {errors: "No comment"}, status: 404
      end
    else
      render json: {errors: "No activity"}, status: 404
    end
  end

  def destroy
    post_comment = PostComment.find_by(id: params[:id])
    if post_comment.present?
      post_comment.destroy
      head 204
    else
      head 404
    end
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:activity_id, :content)
  end


end
