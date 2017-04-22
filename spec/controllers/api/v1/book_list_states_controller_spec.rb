require 'spec_helper'

RSpec.describe Api::V1::BookListStatesController, type: :controller do

  describe "GET #index" do
    it "returns PL names" do
      @book_list_states = BookListState.includes(:book_list_state_translations).where(book_list_state_translations: {country: "PL"}).pluck(:id, :state, :translation, :country).map { |p| { id: p[0], state: p[1], translation: p[2], country: p[3] } }
      get :index, country: "PL"
      book_list_states_response = json_response
      expect(book_list_states_response[:book_list_states]).to eq JSON.parse(@book_list_states.to_json, symbolize_names: true)
    end


    it "returns EN names" do
      @book_list_states = BookListState.includes(:book_list_state_translations).where(book_list_state_translations: {country: "EN"}).pluck(:id, :state, :translation, :country).map { |p| { id: p[0], state: p[1], translation: p[2], country: p[3] } }
      get :index, country: "EN"
      book_list_states_response = json_response
      expect(book_list_states_response[:book_list_states]).to eq JSON.parse(@book_list_states.to_json, symbolize_names: true)
    end
  end
end
