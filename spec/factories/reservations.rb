FactoryGirl.define do
  factory :reservation do
    book_id { FactoryGirl.create(:book).id }
    user_id { FactoryGirl.create(:user).id }
  end
end
