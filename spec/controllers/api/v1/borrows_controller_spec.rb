require 'spec_helper'

RSpec.describe Api::V1::BorrowsController, type: :controller do
  describe "POST #create" do
    before(:each) do
      @user = FactoryGirl.create :user
      @friend = FactoryGirl.create :friend
      api_authorization_header @user.auth_token
      @book = FactoryGirl.create :book
      @user_book = UserBook.create(user_id: @friend.id, book_id: @book.id)
    end

    context "when successful reservation" do
      before(:each) do
        @borrow_attributes = {user_book_id: @user_book.id, borrow_state: 0}
        post :create, {borrow: @borrow_attributes}
      end

      it "renders the json representation for the user record just created" do
        borrow_response = json_response
        expect(borrow_response).to have_key(:success)
      end

      it { should respond_with 201 }
    end

    context "when successful borrowed with login" do
      before(:each) do
        @user_book.user_id = @user.id
        @user_book.save
        @borrow_attributes = {user_book_id: @user_book.id, borrow_state: 1, user_login: @friend.login}
        post :create, {borrow: @borrow_attributes}
      end

      it "renders the json representation for the user record just created" do
        borrow_response = json_response
        expect(borrow_response).to have_key(:success)
      end

      it { should respond_with 201 }
    end

    context "when successful borrowed with name and surname" do
      before(:each) do
        @user_book.user_id = @user.id
        @user_book.save
        @borrow_attributes = {user_book_id: @user_book.id, borrow_state: 1, user_name: @friend.name, user_surname: @friend.surname}
        post :create, {borrow: @borrow_attributes}
      end

      it "renders the json representation for the user record just created" do
        borrow_response = json_response
        expect(borrow_response).to have_key(:success)
      end

      it { should respond_with 201 }
    end

    context "when successful borrowed with login and title of book" do
      before(:each) do
        @user_book.user_id = @user.id
        @user_book.save
        @borrow_attributes = {title: @user_book.book.title, borrow_state: 1, user_login: @friend.login}
        post :create, {borrow: @borrow_attributes}
      end

      it "renders the json representation for the user record just created" do
        borrow_response = json_response
        expect(borrow_response).to have_key(:success)
      end

      it { should respond_with 201 }
    end

    context "when successful borrowed with login and isbn of book" do
      before(:each) do
        @user_book.user_id = @user.id
        @user_book.save
        @borrow_attributes = {isbn: @user_book.book.isbn, borrow_state: 1, user_login: @friend.login}
        post :create, {borrow: @borrow_attributes}
      end

      it "renders the json representation for the user record just created" do
        borrow_response = json_response
        expect(borrow_response).to have_key(:success)
      end

      it { should respond_with 201 }
    end

    context "when successful borrowed with name and title of book" do
      before(:each) do
        @user_book.user_id = @user.id
        @user_book.save
        @borrow_attributes = {title: @user_book.book.title, borrow_state: 1, user_name: @friend.name, user_surname: @friend.surname}
        post :create, {borrow: @borrow_attributes}
      end

      it "renders the json representation for the user record just created" do
        borrow_response = json_response
        expect(borrow_response).to have_key(:success)
      end

      it { should respond_with 201 }
    end

    context "when successful borrowed with name and isbn of book" do
      before(:each) do
        @user_book.user_id = @user.id
        @user_book.save
        @borrow_attributes = {isbn: @user_book.book.isbn, borrow_state: 1, user_name: @friend.name, user_surname: @friend.surname}
        post :create, {borrow: @borrow_attributes}
      end

      it "renders the json representation for the user record just created" do
        borrow_response = json_response
        expect(borrow_response).to have_key(:success)
      end

      it { should respond_with 201 }
    end

    context "when successful borrowed with login and all info about book" do
      before(:each) do
        @user_book.user_id = @user.id
        @user_book.save
        @borrow_attributes = {isbn: @user_book.book.isbn, title: @user_book.book.title, user_book_id: @user_book.id, borrow_state: 1, user_name: @friend.name, user_surname: @friend.surname}
        post :create, {borrow: @borrow_attributes}
      end

      it "renders the json representation for the user record just created" do
        borrow_response = json_response
        expect(borrow_response).to have_key(:success)
      end

      it { should respond_with 201 }
    end

    context "when unsuccessful borrowed with name and title of book" do
      before(:each) do
        @user_book.user_id = @user.id
        @user_book.save
        @borrow_attributes = {title: "Komórka", borrow_state: 1, user_name: @friend.name, user_surname: @friend.surname}
        post :create, {borrow: @borrow_attributes}
      end

      it "renders the json representation for the user record just created" do
        borrow_response = json_response
        expect(borrow_response).to have_key(:errors)
      end

      it { should respond_with 422 }
    end

    context "when unsuccessful reservation" do
      before(:each) do
        @invalid_borrow_attributes = {user_book_id: @user_book.id, borrow_state: 2} #notice I'm not including the email
        post :create, {borrow: @invalid_borrow_attributes}
      end

      it "renders an errors json" do
        borrow_response = json_response
        expect(borrow_response).to have_key(:errors)
      end

      it { should respond_with 422 }
    end

    context "when unsuccessful reservation because already is present" do
      before(:each) do
        @borrow = Borrow.create(user_book_id: @user_book.id, user_id: @user.id, state_id: 0)
        @borrow_attributes = {user_book_id: @user_book.id, borrow_state: 0}
        post :create, {borrow: @borrow_attributes}
      end

      it "renders an errors json" do
        borrow_response = json_response
        expect(borrow_response).to have_key(:errors)
      end

      it { should respond_with 409 }
    end

    context "when unsuccessful reservation because already reserved" do
      before(:each) do
        @borrow = Borrow.create(user_book_id: @user_book.id, user_id: @user.id+1, state_id: 0)
        @borrow_attributes = {user_book_id: @user_book.id, borrow_state: 0}
        post :create, {borrow: @borrow_attributes}
      end

      it "renders an errors json" do
        borrow_response = json_response
        expect(borrow_response).to have_key(:errors)
      end

      it { should respond_with 409 }
    end

  end

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
  #
  # end
end
