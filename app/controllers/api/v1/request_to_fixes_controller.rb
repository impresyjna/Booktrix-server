class Api::V1::RequestToFixesController < ApplicationController
  before_action :authenticate_with_http_token, only: [:create]

  def create
    user = current_user
    request_to_fix = user.request_to_fixes.build(request_to_fix_params)
    if Book.where(id:params[:request_to_fix][:book_id]).first.present?
      if request_to_fix.save
        render json: {success: "Success"}, status: 201
      else
        render json: {errors: request_to_fix.errors}, status: 422
      end
    else
      render json: {errors: request_to_fix.errors}, status: 422
    end

  end

  private

  def request_to_fix_params
    params.require(:request_to_fix).permit(:book_id, :notice)
  end
end
