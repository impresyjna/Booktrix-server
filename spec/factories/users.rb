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

  factory :friend, class: User do
    email {FFaker::Internet.email}
    password "12345678"
    password_confirmation "12345678"
    login "login1"
    name "Adam"
    surname "Nowak"
    user_setting {FactoryGirl.create(:user_setting) }
  end
end
