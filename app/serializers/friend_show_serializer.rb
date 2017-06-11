class FriendShowSerializer < ActiveModel::Serializer
  attributes :id, :login, :name, :surname, :books_count, :books, :gifts, :borrowed

  def books_count
    object.user_books.count
  end

  def books
    ActiveModel::Serializer::CollectionSerializer.new(object.user_books, serializer: UserBookSerializer)
  end

  def gifts
    ActiveModel::Serializer::CollectionSerializer.new(object.gifts, serializer: GiftSerializer)
  end

  def borrowed

  end
end
