class BookActivity < ApplicationRecord
  actable
  acts_as :activity
  belongs_to :book
end
