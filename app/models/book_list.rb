class BookList < ApplicationRecord
  belongs_to :book
  belongs_to :user
  belongs_to :book_list_state
end
