require 'spec_helper'

RSpec.describe Api::V1::BooksController, type: :controller do
  # describe "GET #found_by_isbn" do
  #   context "when is successfully founded" do
  #     before(:each) do
  #       @book = FactoryGirl.create :book
  #       get :found_by_isbn, isbn: @book.isbn
  #     end
  #
  #     it "returns the information about founded book" do
  #       book_response = json_response
  #       expect(book_response[:title]).to eql @book.title
  #     end
  #
  #     it { should respond_with 200 }
  #   end
  #
  #
  #   context "when book doesn't exist" do
  #     before(:each) do
  #       @book = FactoryGirl.create :book
  #       @book.isbn = "9788373378124"
  #       get :found_by_isbn, isbn: @book.isbn
  #     end
  #
  #     it { should respond_with 404 }
  #   end
  # end
end
