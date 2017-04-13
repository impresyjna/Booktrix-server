FactoryGirl.define do
  factory :borrowed do
    user_book nil
    user nil
    user_name "MyString"
    user_surname "MyString"
    state nil
  end
end
