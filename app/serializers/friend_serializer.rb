class FriendSerializer < ActiveModel::Serializer
  attributes :id, :email, :login, :name, :surname

  #TODO: Serializer with condition to show name and surname
end
