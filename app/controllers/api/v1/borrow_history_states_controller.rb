class Api::V1::BorrowHistoryStatesController < ApplicationController
  respond_to :json

  def index
    @borrow_history_states = BorrowHistoryState.includes(:borrow_history_state_trans).where(borrow_history_state_trans: {country: params[:country]}).pluck(:id, :state, :translation, :country).map { |p| { id: p[0], state: p[1], translation: p[2], country: p[3] } }
    render json: { "borrow_history_state_trans" => @borrow_history_states }, adapter: :json, status: 200
  end
end
