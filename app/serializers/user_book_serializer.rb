class UserBookSerializer < ActiveModel::Serializer
  attributes :id, :book, :category, :borrower

  def book
    BookSerializer.new(object.book, { root: false } )
  end

  def category
    if object.category.present?
      CategorySerializer.new(object.category, { root: false } )
    end
  end

  def borrower
    if object.borrowed
      FriendSerializer.new(Borrow.where(user_book_id: object.id).first.user, { root: false } )
    end
  end
end
