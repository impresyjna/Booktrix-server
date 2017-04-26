class ReservationSerializer < ActiveModel::Serializer
  attributes :id, :book, :owner

  def book
    BookSerializer.new(object.gift.book, { root: false } )
  end

  def owner
    FriendSerializer.new(object.gift.user, { root: false } )
  end
end
