class Book < ApplicationRecord
  scoped_search on: [:title, :isbn, :author, :publisher]
  # TODO: ISBN MUST BE UNIQ
end
