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
      end

      it { should respond_with 200 }
    end

    context "get list of borrowed books" do
      before(:each) do
        @user_book = UserBook.create(book_id: @book.id, user_id: @user.id, borrowed: true)
        @borrow = Borrow.create(user_book_id: @user_book.id, user_id: @user.id, state_id: 0)
        get :index, borrowed: true
        user_books_response = json_response
      end

      it { should respond_with 200 }
    end
  end

  describe "GET #show" do
    before(:each) do
      @user = FactoryGirl.create :user
      api_authorization_header @user.auth_token
      @book = FactoryGirl.create :book
      @user_book = UserBook.create(book_id: @book.id, user_id: @user.id)
    end

    context "when category belongs to user and exists" do
      before(:each) do
        get :show, id: @user_book.id
        user_book_response = json_response
        expect(user_book_response).to have_key(:book)
        expect(user_book_response).to have_key(:category)
      end
      it { should respond_with 200 }
    end

    context "when category doesn't belong to user or exists" do
      before(:each) do
        get :show, id: @user_book.id + 1
      end

      it { should respond_with 404 }

    end
  end

  describe "POST #create" do
    before(:each) do
      @user = FactoryGirl.create :user
      api_authorization_header @user.auth_token
      @category = FactoryGirl.create :category
      @book  = FactoryGirl.create :book
    end

    context "when is successfully created" do
      before(:each) do
        @book_attributes = FactoryGirl.attributes_for :book
        post :create, {book: @book_attributes, category: @category.id}
      end

      it "renders the json representation for the user record just created" do
        user_book_response = json_response
        expect(user_book_response).to have_key(:book)
        expect(user_book_response).to have_key(:category)
      end

      it { should respond_with 201 }
    end

    context "when is successfully created with earlier existing book" do
      before(:each) do
        @book_attributes = FactoryGirl.attributes_for :book
        post :create, {book: @book_attributes, category: @category.id}
      end

      it "renders the json representation for the user record just created" do
        user_book_response = json_response
        expect(user_book_response).to have_key(:book)
        expect(user_book_response).to have_key(:category)
        expect(user_book_response[:book][:id]).to eql @book.id
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        @invalid_book_attributes = {title: "", isbn: ""} #notice I'm not including the email
        post :create, {book: @invalid_book_attributes, category: @category.id}
      end

      it "renders an errors json" do
        user_book_response = json_response
        expect(user_book_response).to have_key(:errors)
      end

      it { should respond_with 422 }
    end
  end

  describe "PUT/PATCH #update" do
    before(:each) do
      @user = FactoryGirl.create :user
      api_authorization_header @user.auth_token
      @category = FactoryGirl.create :category
      @book  = FactoryGirl.create :book
      @user_book = UserBook.create(book_id: @book.id, user_id: @user.id)
    end

    context "when is successfully updated" do
      before(:each) do
        patch :update, {id: @user_book.id, category: @category.id, book: {title: "GoodOne"}}
      end

      it "renders the json representation for the updated user" do
        user_book_response = json_response
        expect(user_book_response[:book][:title]).to eql "GoodOne"
        expect(user_book_response[:book][:isbn]).to eql @book.isbn
      end

      it { should respond_with 200 }
    end

    context "when is not updated" do
      before(:each) do
        patch :update, {id: @user_book.id, category: @category.id, book: {title: ""}}
      end

      it "renders an errors json" do
        user_book_response = json_response
        expect(user_book_response).to have_key(:errors)
      end

      it { should respond_with 422 }
    end

    context "when update is impossible - category doesn't exist" do
      before(:each) do
        patch :update, {id: @user_book.id+1, category: @category.id, book: {title: "GoodOne"}}
      end

      it { should respond_with 422 }
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @user = FactoryGirl.create :user
      api_authorization_header @user.auth_token
      @category = FactoryGirl.create :category
      @book  = FactoryGirl.create :book
      @user_book = UserBook.create(book_id: @book.id, user_id: @user.id)
    end

    context "when delete success" do
      before(:each) do
        delete :destroy, {id: @user_book.id}
      end

      it { should respond_with 204 }
    end

    context "when cannot delete - category doesn't exists" do
      before(:each) do
        delete :destroy, {id: @user_book.id+1}
      end

      it { should respond_with 422 }
    end
  end

end
