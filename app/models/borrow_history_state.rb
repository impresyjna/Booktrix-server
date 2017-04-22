class BorrowHistoryState < ApplicationRecord
  has_many :borrow_history_state_trans
  enum state: [ :reserved, :borrowed, :returned, :demolished ]
end
