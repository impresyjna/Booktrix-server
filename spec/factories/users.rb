FactoryGirl.define do
  factory :user do
    email {FFaker::Internet.email}
    password "12345678"
    password_confirmation "12345678"
    login "login"
    name "Adam"
    surname "Nowak"
    user_setting {FactoryGirl.create(:user_setting) }
  end
end
