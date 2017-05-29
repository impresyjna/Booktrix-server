class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :color, :font_color, :user_books_count

  def user_books_count
    object.user_books.count
  end

end
