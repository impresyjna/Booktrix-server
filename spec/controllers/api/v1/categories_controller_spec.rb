require 'spec_helper'

RSpec.describe Api::V1::CategoriesController, type: :controller do
  describe "GET #index" do
    before(:each) do
      @user = FactoryGirl.create :user
      api_authorization_header @user.auth_token
      get :index
      categories_response = json_response
      expect(categories_response).to have_key(:categories)
    end
    it { should respond_with 200 }
  end

  describe "GET #show" do

  end

  describe "POST #create" do

  end

  describe "PUT/PATCH #update" do

  end

  describe "DELETE #destroy" do

  end
end
