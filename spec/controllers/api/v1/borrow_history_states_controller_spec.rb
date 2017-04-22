require 'spec_helper'

RSpec.describe Api::V1::BorrowHistoryStatesController, type: :controller do

  describe "GET #index" do
    it "returns PL names" do
      @borrow_history_states = BorrowHistoryState.includes(:borrow_history_state_trans).where(borrow_history_state_trans: {country: "PL"}).pluck(:id, :state, :translation, :country).map { |p| { id: p[0], state: p[1], translation: p[2], country: p[3] } }
      get :index, country: "PL"
      borrow_history_state_trans = json_response
      expect(borrow_history_state_trans[:borrow_history_state_trans]).to eq JSON.parse(@borrow_history_states.to_json, symbolize_names: true)
    end


    it "returns EN names" do
      @borrow_history_states = BorrowHistoryState.includes(:borrow_history_state_trans).where(borrow_history_state_trans: {country: "EN"}).pluck(:id, :state, :translation, :country).map { |p| { id: p[0], state: p[1], translation: p[2], country: p[3] } }
      get :index, country: "EN"
      borrow_history_state_trans = json_response
      expect(borrow_history_state_trans[:borrow_history_state_trans]).to eq JSON.parse(@borrow_history_states.to_json, symbolize_names: true)
    end
  end

end
