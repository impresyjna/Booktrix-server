FactoryGirl.define do
  factory :gift do
    book_id { FactoryGirl.create(:book).id }
    user_id { FactoryGirl.create(:user).id }
    reserved false
    title "MyString"
    author "MyString"
    isbn "MyString"
  end
end
