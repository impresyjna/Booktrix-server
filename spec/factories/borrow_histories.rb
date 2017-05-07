FactoryGirl.define do
  factory :borrow_history do
    user_book "MyString"
    references "MyString"
    user nil
    user_name "MyString"
    user_surname "MyString"
    borrow_history_state nil
  end
end
