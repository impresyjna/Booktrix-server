class UserBook < ApplicationRecord
  belongs_to :book
  belongs_to :category
  belongs_to :user
end
