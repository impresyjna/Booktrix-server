require 'spec_helper'

RSpec.describe Api::V1::BookListsController, type: :controller do

  describe "GET #index" do
    before(:each) do
      @user = FactoryGirl.create :user
      api_authorization_header @user.auth_token
    end

    context "when want_to_read" do
      before(:each) do
        get :index, {state_id: 0}
        book_list_response = json_response
        expect(book_list_response).to have_key(:book_lists)
      end
      it { should respond_with 200 }
    end

    context "when reading" do
      before(:each) do
        get :index, {state_id: 1}
        book_list_response = json_response
        expect(book_list_response).to have_key(:book_lists)
      end
      it { should respond_with 200 }
    end

    context "when read" do
      before(:each) do
        get :index, {state_id: 2}
        book_list_response = json_response
        expect(book_list_response).to have_key(:book_lists)
      end
      it { should respond_with 200 }
    end


  end

  describe "POST #create" do
    before(:each) do
      @user = FactoryGirl.create :user
      api_authorization_header @user.auth_token
      @book = FactoryGirl.create :book
    end

    context "when is successfully created want_to_read" do
      before(:each) do
        @book_list_attributes = {book_id: @book.id, book_list_state_id: 0}
        post :create, {book_list: @book_list_attributes}
      end

      it "renders the json representation for the user record just created" do
        book_list_response = json_response
        expect(book_list_response).to have_key(:success)
      end

      it { should respond_with 201 }
    end

    context "when is successfully created reading" do
      before(:each) do
        @book_list_attributes = {book_id: @book.id, book_list_state_id: 1}
        post :create, {book_list: @book_list_attributes}
      end

      it "renders the json representation for the user record just created" do
        book_list_response = json_response
        expect(book_list_response).to have_key(:success)
      end

      it { should respond_with 201 }
    end

    context "when is successfully created read" do
      before(:each) do
        @book_list_attributes = {book_id: @book.id, book_list_state_id: 2}
        post :create, {book_list: @book_list_attributes}
      end

      it "renders the json representation for the user record just created" do
        book_list_response = json_response
        expect(book_list_response).to have_key(:success)
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        @invalid_book_list_attributes = {book_id: @book.id+1, book_list_state_id: 0} #notice I'm not including the email
        post :create, {category: @invalid_book_list_attributes}
      end

      it "renders an errors json" do
        book_list_response = json_response
        expect(book_list_response).to have_key(:errors)
      end

      it "renders the json errors on why the user could not be created" do
        book_list_response = json_response
        expect(book_list_response).to have_key(:errors)
      end

      it { should respond_with 422 }
    end
  end
  #
  # describe "PUT/PATCH #update" do
  #   before(:each) do
  #     @user = FactoryGirl.create :user
  #     api_authorization_header @user.auth_token
  #     @category = FactoryGirl.create :category
  #     @category.user_id = @user.id
  #     @category.save
  #   end
  #
  #   context "when is successfully updated" do
  #     before(:each) do
  #       patch :update, {id: @category.id, category: {name: "GoodOne", color: "#b80000", font_color: "#b80000"}}
  #     end
  #
  #     it "renders the json representation for the updated user" do
  #       category_response = json_response
  #       expect(category_response[:category][:name]).to eql "GoodOne"
  #       expect(category_response[:category][:color]).to eq "#b80000"
  #       expect(category_response[:category][:font_color]).to eq "#b80000"
  #     end
  #
  #     it { should respond_with 200 }
  #   end
  #
  #   context "when is not updated" do
  #     before(:each) do
  #       patch :update, {id: @category.id, category: {name: "", color: "b80000", font_color: "b80000"}}
  #     end
  #
  #     it "renders an errors json" do
  #       category_response = json_response
  #       expect(category_response).to have_key(:errors)
  #     end
  #
  #     it "renders the json errors on whye the user could not be updated" do
  #       category_response = json_response
  #       expect(category_response[:errors][:name]).to include "can't be blank"
  #       expect(category_response[:errors][:color]).to include "is invalid"
  #       expect(category_response[:errors][:font_color]).to include "is invalid"
  #     end
  #
  #     it { should respond_with 422 }
  #   end
  #
  #   context "when update is impossible - category doesn't exist" do
  #     before(:each) do
  #       @category.user_id = @category.user_id + 1
  #       @category.save
  #       patch :update, {id: @category.id, category: {name: "GoodOne", color: "#b80000", font_color: "#b80000"}}
  #     end
  #
  #     it { should respond_with 422 }
  #   end
  # end
  #
  # describe "DELETE #destroy" do
  #   before(:each) do
  #     @user = FactoryGirl.create :user
  #     api_authorization_header @user.auth_token
  #     @category = FactoryGirl.create :category
  #     @category.user_id = @user.id
  #     @category.save
  #   end
  #
  #   context "when delete success" do
  #     before(:each) do
  #       delete :destroy, {id: @category.id}
  #     end
  #
  #     it { should respond_with 204 }
  #   end
  #
  #   context "when cannot delete - category doesn't exists" do
  #     before(:each) do
  #       @category.user_id = @category.user_id + 1
  #       @category.save
  #       delete :destroy, {id: @category.id}
  #     end
  #
  #     it { should respond_with 422 }
  #   end
  # end
end
