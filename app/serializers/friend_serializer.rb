class FriendSerializer < ActiveModel::Serializer
  attributes :id, :email, :login, :name, :surname, :books_count

  def books_count
    object.user_books.count
  end
end
