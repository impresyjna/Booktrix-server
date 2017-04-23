require 'spec_helper'

RSpec.describe Api::V1::BooksController, type: :controller do
  describe "GET #found_by_isbn" do
    context "when is successfully founded" do
      before(:each) do
        @book = FactoryGirl.create :book
        get :found_by_isbn, isbn: @book.isbn
      end

      it "returns the information about founded book" do
        book_response = json_response
        expect(book_response[:title]).to eql @book.title
      end

      it { should respond_with 200 }
    end


    context "when book doesn't exist" do
      before(:each) do
        @book = FactoryGirl.create :book
        @book.isbn = "9788373378124"
        get :found_by_isbn, isbn: @book.isbn
      end

      it { should respond_with 404 }
    end
  end

  describe "GET #index" do
    before(:each) do
      @book = FactoryGirl.create :book
    end

    context "when params given" do
      before(:each) do
        @books = Book.where(title: "Opium w rosole")
        get :index, query: 'Opium w rosole'
        book_response = json_response
        expect(book_response[:books]).to eql JSON.parse(@books.to_json, symbolize_names: true)
      end

      it { should respond_with 200 }


    end

    context "when params not given" do
      before(:each) do
        @books = Book.all
        get :index
        book_response = json_response
        expect(book_response[:books]).to eql JSON.parse(@books.to_json, symbolize_names: true)

      end

      it { should respond_with 200 }

    end

    context "when book not in database" do
      before(:each) do
        @books = Book.where(title: "Lśnienie")
        get :index, query: 'Lśnienie'
        book_response = json_response
        expect(book_response[:books]).to eql JSON.parse(@books.to_json, symbolize_names: true)

      end

      it { should respond_with 200 }

    end
  end
end
