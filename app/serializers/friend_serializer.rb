class FriendSerializer < ActiveModel::Serializer
  attributes :id, :email, :login, :name, :surname
end
