class Api::V1::BorrowHistoriesController < ApplicationController
  before_action :authenticate_with_http_token, only: [:index]
  respond_to :json

  def index
    user = current_user

  end

end
