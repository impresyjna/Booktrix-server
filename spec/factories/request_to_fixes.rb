FactoryGirl.define do
  factory :request_to_fix do
    book_id { FactoryGirl.create(:book).id }
    user_id { FactoryGirl.create(:user).id }
    notice "MyText"
  end
end
