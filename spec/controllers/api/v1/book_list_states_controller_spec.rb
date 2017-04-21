require 'spec_helper'

RSpec.describe Api::V1::BookListStatesController, type: :controller do

  describe "GET #index" do
    it "returns PL names" do
      @book_list_states = BookListState.where(country: "PL")
      get :index, country: "PL"
      book_list_states_response = json_response
      expect(book_list_states_response[:book_list_states]).to eq JSON.parse(@book_list_states.to_json, symbolize_names: true)
    end


    it "returns EN names" do
      @book_list_states = BookListState.where(country: "EN")
      get :index, country: "EN"
      book_list_states_response = json_response
      expect(book_list_states_response[:book_list_states]).to eq JSON.parse(@book_list_states.to_json, symbolize_names: true)
    end
  end

  #TODO: Make this with translation

end
