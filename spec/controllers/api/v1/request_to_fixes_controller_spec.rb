require 'spec_helper'

RSpec.describe Api::V1::RequestToFixesController, type: :controller do
  describe "POST #create" do
    before(:each) do
      @user = FactoryGirl.create :user
      @book = FactoryGirl.create :book
      @request_to_fix = FactoryGirl.build :request_to_fix
      api_authorization_header @user.auth_token
    end

    context "when is successfully created" do
      before(:each) do
        post :create, {request_to_fix: @request_to_fix}
      end

      it "renders the json representation for the user record just created" do
        request_to_fix_response = json_response
        expect(request_to_fix_response).to have_key(:success)
      end

      it { should respond_with 201 }
    end

    context "when is successfully created with blank notice" do
      before(:each) do
        @request_to_fix.notice = ''
        post :create, {request_to_fix: @request_to_fix}
      end

      it "renders the json representation for the user record just created" do
        request_to_fix_response = json_response
        expect(request_to_fix_response).to have_key(:success)
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        @request_to_fix.book_id = 1000
        post :create, {request_to_fix: @request_to_fix}
      end

      it "renders an errors json" do
        request_to_fix_response = json_response
        expect(request_to_fix_response).to have_key(:errors)
      end

      it { should respond_with 422 }
    end
  end

end
