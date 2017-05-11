class MarkActivity < ApplicationRecord
  acts_as :book_activity
  belongs_to :mark
end
