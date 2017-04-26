require 'spec_helper'

RSpec.describe Api::V1::ReservationsController, type: :controller do
  describe "GET #index" do
    before(:each) do
      @user = FactoryGirl.create :user
      api_authorization_header @user.auth_token
      @gift = FactoryGirl.create :gift
      @gift.user_id = @user.id
      @gift.save
      @reservation = Reservation.create(user_id: @user.id, gift_id: @gift.id)
      get :index
      reservations_response = json_response
      expect(reservations_response).to have_key(:reservations)
    end
    it { should respond_with 200 }
  end

  # describe "POST #create" do
  #   before(:each) do
  #     @user = FactoryGirl.create :user
  #     api_authorization_header @user.auth_token
  #   end
  #
  #   context "when is successfully created" do
  #     before(:each) do
  #       @gift_attributes = {title: "Lśnienie", author: "Stephen King", isbn: ""}
  #       post :create, {gift: @gift_attributes}
  #     end
  #
  #     it "renders the json representation for the user record just created" do
  #       gift_response = json_response
  #       expect(gift_response).to have_key(:gift)
  #     end
  #
  #     it { should respond_with 201 }
  #   end
  #
  #   context "when is successfully created with isbn" do
  #     before(:each) do
  #       @book = FactoryGirl.create :book
  #       @gift_attributes = {title: @book.title, author: @book.author, isbn: @book.isbn}
  #       post :create, {gift: @gift_attributes}
  #     end
  #
  #     it "renders the json representation for the user record just created" do
  #       gift_response = json_response
  #       expect(gift_response).to have_key(:gift)
  #       expect(gift_response[:gift][:book][:title]).to eql @book.title
  #       expect(gift_response[:gift][:book][:id]).to eql @book.id
  #     end
  #
  #     it { should respond_with 201 }
  #   end
  #
  #   context "when is not created" do
  #     before(:each) do
  #       @invalid_gift_attributes = {title: "", author: "Stephen King", isbn: ""} #notice I'm not including the email
  #       post :create, {category: @invalid_gift_attributes}
  #     end
  #
  #     it "renders an errors json" do
  #       gift_response = json_response
  #       expect(gift_response).to have_key(:errors)
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
  #     @gift = FactoryGirl.create :gift
  #     @gift.user_id = @user.id
  #     @gift.save
  #     @reservation = Reservation.create(user_id: @user.id, gift_id: @gift.id)
  #   end
  #
  #   context "when delete success" do
  #     before(:each) do
  #       delete :destroy, {id: @gift.id}
  #     end
  #
  #     it "reservations should be destroyed" do
  #       expect(@user.reservations).to be_empty
  #     end
  #
  #     it { should respond_with 204 }
  #   end
  #
  #   context "when cannot delete - category doesn't exists" do
  #     before(:each) do
  #       @gift.user_id = @gift.user_id + 1
  #       @gift.save
  #       delete :destroy, {id: @gift.id}
  #     end
  #
  #     it { should respond_with 422 }
  #   end
  # end
end
