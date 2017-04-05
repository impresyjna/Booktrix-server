class UserSettingSerializer < ActiveModel::Serializer
  attributes :show_full_name, :show_gifts_boolean, :show_activities, :show_books
end
