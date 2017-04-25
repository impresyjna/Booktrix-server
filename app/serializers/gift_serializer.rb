class GiftSerializer < ActiveModel::Serializer
  attributes :id, :book

  def book
    BookSerializer.new(object.book, { root: false } )
  end
end
