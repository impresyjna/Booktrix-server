class Borrowed < ApplicationRecord
  belongs_to :user_book
  belongs_to :user
  belongs_to :state
end
