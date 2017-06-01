class Category < ApplicationRecord
  belongs_to :user
  has_many :user_books

  validates :name, presence: true

  VALID_COLOR_REGEX = /\A#(?:[0-9a-fA-F]{3}){1,2}\z/i
end
