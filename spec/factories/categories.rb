FactoryGirl.define do
  factory :category do
    name "Category"
    color "#ffffff"
    font_color "#000000"
    user_id { FactoryGirl.create(:user).id }
  end
end
