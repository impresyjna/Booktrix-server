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

  describe "POST #create" do
    before(:each) do
      @user = FactoryGirl.create :user
      api_authorization_header @user.auth_token
      @gift = FactoryGirl.create :gift
      @friend = FactoryGirl.create :friend
      @user.friend_request(@friend)
      @friend.accept_request(@user)
      @gift.user_id = @friend.id
      @gift.save
    end

    context "when is successfully created" do
      before(:each) do
        @reservation_attributes = {gift_id: @gift.id}
        post :create, {reservation: @reservation_attributes}
      end

      it "renders the json representation for the user record just created" do
        reservation_response = json_response
        expect(reservation_response).to have_key(:reservation)
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        @invalid_reservation_attributes = {gift_id: 0} #notice I'm not including the email
        post :create, {reservation: @invalid_reservation_attributes}
      end

      it "renders an errors json" do
        reservation_response = json_response
        expect(reservation_response).to have_key(:errors)
      end

      it { should respond_with 422 }
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @user = FactoryGirl.create :user
      api_authorization_header @user.auth_token
      @gift = FactoryGirl.create :gift
      @friend = FactoryGirl.create :friend
      @user.friend_request(@friend)
      @friend.accept_request(@user)
      @gift.user_id = @friend.id
      @gift.save
      @reservation = Reservation.create(user_id: @user.id, gift_id: @gift.id)
    end

    context "when delete success" do
      before(:each) do
        delete :destroy, {id: @reservation.id}
      end

      it "reservations should be destroyed" do
        expect(@user.reservations).to be_empty
      end

      it { should respond_with 204 }
    end

    context "when cannot delete - category doesn't exists" do
      before(:each) do
        @reservation.user_id = @reservation.user_id + 1
        @reservation.save
        delete :destroy, {id: @reservation.id}
      end

      it { should respond_with 422 }
    end
  end
end
