class BookSerializer < ActiveModel::Serializer
  attributes :id, :title, :author, :publisher, :isbn, :image, :description, :publish_date, :page_count, :publisher_city, :marks

  #TODO: Nested fields
  def marks
    object.marks
  end
end
