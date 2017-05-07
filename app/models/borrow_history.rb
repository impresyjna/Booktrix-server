class BorrowHistory < ApplicationRecord
  belongs_to :user
  belongs_to :borrow_history_state
end
