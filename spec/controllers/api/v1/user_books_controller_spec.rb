require 'spec_helper'

RSpec.describe Api::V1::UserBooksController, type: :controller do
  describe "GET #index" do
    before(:each) do
      @user = FactoryGirl.create :user
      api_authorization_header @user.auth_token
      @book = FactoryGirl.create :book
    end

    context "get list of books in library" do
      before(:each) do
        @user_book = UserBook.create(book_id: @book.id, user_id: @user.id)
        get :index, borrowed: false
        user_books_response = json_response
        expect(user_books_response).to have_key(:user_books)
      end

      it { should respond_with 200 }
    end


    context "get list of borrowed books" do
      before(:each) do
        @user_book = UserBook.create(book_id: @book.id, user_id: @user.id, borrowed: true)
        get :index, borrowed: true
        user_books_response = json_response
        expect(user_books_response).to have_key(:user_books)
      end

      it { should respond_with 200 }
    end


  end

  # describe "GET #show" do
  #   before(:each) do
  #     @user = FactoryGirl.create :user
  #     api_authorization_header @user.auth_token
  #     @category = FactoryGirl.create :category
  #   end
  #
  #   context "when category belongs to user and exists" do
  #     before(:each) do
  #       @category.user_id = @user.id
  #       @category.save
  #       get :show, id: @category.id
  #       category_response = json_response
  #       expect(category_response).to have_key(:category)
  #       expect(category_response[:category][:name]).to eql @category.name
  #     end
  #     it { should respond_with 200 }
  #   end
  #
  #   context "when category doesn't belong to user or exists" do
  #     before(:each) do
  #       get :show, id: @category.id
  #     end
  #
  #     it { should respond_with 404 }
  #
  #   end
  #
  #
  # end
  #
  # describe "POST #create" do
  #   before(:each) do
  #     @user = FactoryGirl.create :user
  #     api_authorization_header @user.auth_token
  #   end
  #
  #   context "when is successfully created" do
  #     before(:each) do
  #       @category_attributes = FactoryGirl.attributes_for :category
  #       post :create, {category: @category_attributes}
  #     end
  #
  #     it "renders the json representation for the user record just created" do
  #       category_response = json_response
  #       expect(category_response[:category][:name]).to eql @category_attributes[:name]
  #     end
  #
  #     it { should respond_with 201 }
  #   end
  #
  #   context "when is not created" do
  #     before(:each) do
  #       @invalid_category_attributes = {name: ""} #notice I'm not including the email
  #       post :create, {category: @invalid_category_attributes}
  #     end
  #
  #     it "renders an errors json" do
  #       category_response = json_response
  #       expect(category_response).to have_key(:errors)
  #     end
  #
  #     it "renders the json errors on why the user could not be created" do
  #       category_response = json_response
  #       expect(category_response[:errors][:name]).to include "can't be blank"
  #     end
  #
  #     it { should respond_with 422 }
  #   end
  # end
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


  end
