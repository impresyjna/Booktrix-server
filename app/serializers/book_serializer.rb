class BookSerializer < ActiveModel::Serializer
  attributes :id, :title, :author, :publisher, :isbn, :image, :description, :publish_date, :page_count, :publisher_city
end
