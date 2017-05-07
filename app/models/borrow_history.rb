class BorrowHistory < ApplicationRecord
  belongs_to :user_book
  belongs_to :user
  belongs_to :borrow_history_state
end
