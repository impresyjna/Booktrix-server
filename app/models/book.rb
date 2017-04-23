class Book < ApplicationRecord
  scoped_search on: [:title, :isbn, :author, :publisher]
  validate :check_length

  VALID_ISBN_REGEX = /\A^[0-9]+\z/i
  validates :isbn, presence: true, format: { with: VALID_ISBN_REGEX }

  def check_length
    unless self.isbn.present? || self.isbn.size == 10 or isbn.size == 13
      errors.add(:isbn, "length must be 10 or 13")
    end
  end
end
