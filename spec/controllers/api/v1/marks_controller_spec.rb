require 'spec_helper'

RSpec.describe Api::V1::MarksController, type: :controller do

  describe "POST #create" do
    before(:each) do
      @user = FactoryGirl.create :user
      @book = FactoryGirl.create :book
      api_authorization_header @user.auth_token
    end

    context "when is successfully created" do
      before(:each) do
        @mark_attributes = {book_id: @book.id, value: 10, comment: "Text"}
        post :create, {mark: @mark_attributes}
      end

      it "renders the json representation for the user record just created" do
        mark_response = json_response
        expect(mark_response).to have_key(:success)
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        @invalid_mark_attributes = {book_id: @book.id+1, value: 10, comment: "Text"}
        post :create, {mark: @invalid_mark_attributes}
      end

      it "renders an errors json" do
        mark_response = json_response
        expect(mark_response).to have_key(:errors)
      end

      it { should respond_with 422 }
    end
  end

  describe "PUT/PATCH #update" do
    before(:each) do
      @user = FactoryGirl.create :user
      @book = FactoryGirl.create :book
      api_authorization_header @user.auth_token
      @mark = Mark.create(book_id: @book.id, user_id: @user.id, value: 10, comment: "Text")
    end

    context "when is successfully updated" do
      before(:each) do
        patch :update, {id: @mark.id, mark: {value: 5, comment: "Text"}}
      end

      it "renders the json representation for the updated user" do
        mark_response = json_response
        expect(mark_response).to have_key(:success)
      end

      it { should respond_with 200 }
    end

    context "when is not updated" do
      before(:each) do
        patch :update, {id: @mark.id, mark: {value: nil, comment: ""} }
      end

      it "renders an errors json" do
        mark_response = json_response
        expect(mark_response).to have_key(:errors)
      end

      it { should respond_with 422 }
    end

    context "when update is impossible - category doesn't exist" do
      before(:each) do
        @mark.user_id = @mark.user_id + 1
        @mark.save
        patch :update, {id: @mark.id, mark: {value: 5, comment: "Text"}}
      end

      it { should respond_with 422 }
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @user = FactoryGirl.create :user
      @book = FactoryGirl.create :book
      api_authorization_header @user.auth_token
      @mark = Mark.create(book_id: @book.id, user_id: @user.id, value: 10, comment: "Text")
    end

    context "when delete success" do
      before(:each) do
        delete :destroy, {id: @mark.id}
      end

      it { should respond_with 204 }
    end

    context "when cannot delete - category doesn't exists" do
      before(:each) do
        @mark.user_id = @mark.user_id + 1
        @mark.save
        delete :destroy, {id: @mark.id}
      end

      it { should respond_with 422 }
    end

  end

end
