class BorrowHistoryState < ApplicationRecord
  enum state: [ :reserved, :borrowed, :returned, :demolished ]
end
