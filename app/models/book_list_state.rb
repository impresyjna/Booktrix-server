class BookListState < ApplicationRecord
  has_many :book_list_state_translations

  enum state: [ :want_to_read, :reading, :read ]
end
