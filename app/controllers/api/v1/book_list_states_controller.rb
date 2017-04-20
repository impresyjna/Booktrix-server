class Api::V1::BookListStatesController < ApplicationController
  respond_to :json

  def index
    @book_list_states = BookListState.where(country: params[:country])
    render json: { "book_list_states" => @book_list_states }, adapter: :json, status: 200
  end

end
