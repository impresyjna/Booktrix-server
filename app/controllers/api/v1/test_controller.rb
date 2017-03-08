class Api::V1::TestController < ApplicationController
  def index
    render json: {status:100}
  end
end
