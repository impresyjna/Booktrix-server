class Book < ApplicationRecord
  scoped_search on: [:title, :isbn, :author, :publisher]
  has_many :marks
  ISBN10_REGEX = /^(?:\d[\ |-]?){9}[\d|X]$/i
  ISBN13_REGEX = /^(?:\d[\ |-]?){13}$/i
  validates :isbn, numericality: true, uniqueness: true, allow_blank: true, allow_nil: true
  validates :title, presence: true

  validate :check_length

  def check_length
    if !isbn.empty?
      unless (isbn || '').match(ISBN10_REGEX) || (isbn || '').match(ISBN13_REGEX)
        errors.add(:isbn, "length must be 10 or 13")
      end
    end
  end
end
