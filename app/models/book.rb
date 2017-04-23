class Book < ApplicationRecord
  scoped_search on: [:title, :isbn, :author, :publisher]

  ISBN10_REGEX = /^(?:\d[\ |-]?){9}[\d|X]$/i
  ISBN13_REGEX = /^(?:\d[\ |-]?){13}$/i
  validates :isbn, presence: true, numericality: true

  validate :check_length

  def check_length
    unless (isbn || '').match(ISBN10_REGEX) || (isbn || '').match(ISBN13_REGEX)
      errors.add(:isbn, "length must be 10 or 13")
    end
  end
end
