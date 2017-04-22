class Api::V1::BookListStatesController < ApplicationController
  respond_to :json

  def index
    @book_list_states = BookListState.includes(:book_list_state_translations).where(book_list_state_translations: {country: params[:country]}).pluck(:id, :state, :translation, :country).map { |p| { id: p[0], state: p[1], translation: p[2], country: p[3] } }
    render json: { "book_list_states" => @book_list_states }, adapter: :json, status: 200
  end

end
