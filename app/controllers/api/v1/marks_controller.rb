class Api::V1::MarksController < ApplicationController
  before_action :authenticate_with_http_token, only: [:create, :update, :destroy]
  respond_to :json

  def create
    user = current_user
    if Book.find_by(id: params[:mark][:book_id]).present?
      mark = user.marks.build(mark_params)
      if mark.save
        render json: {success: "Success"}, status: 201
      else
        render json: {errors: mark.errors}, status: 422
      end
    else
      render json: {errors: "No book"}, status: 422
    end
  end

  def update
    user = current_user
    if params[:mark][:value].present? and params[:mark][:value].present?
      mark = user.marks.find_by(id: params[:id])
      if mark.present?
        if mark.update(mark_params)
          render json: {success: "Success"}, status: 200
        else
          render json: {errors: mark.errors}, status: 422
        end
      else
        render json: {errors: "Error"}, status: 422
      end
    else
      render json: {errors: "Error"}, status: 422
    end
  end

  def destroy
    user = current_user
    mark = user.marks.find_by(id: params[:id])
    if mark.present?
      mark.destroy
      head 204
    else
      head 422
    end
  end

  def mark_params
    params.require(:mark).permit(:book_id, :value, :comment)
  end

end
