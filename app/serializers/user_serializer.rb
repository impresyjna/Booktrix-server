class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :auth_token, :login, :name, :surname, :user_setting
end
