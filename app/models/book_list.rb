class BookList < ApplicationRecord
  belongs_to :book
  belongs_to :book_list_state
  belongs_to :user
end
