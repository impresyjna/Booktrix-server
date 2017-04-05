class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :auth_token, :login, :name, :surname, :user_setting

  has_one :user_setting, serializer: UserSettingSerializer
  def user_setting
    object.user_setting
  end
end
