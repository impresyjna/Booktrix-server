class Gift < ApplicationRecord
  belongs_to :book
  belongs_to :user

  has_one :reservation, dependent: :destroy

  validates :user_id, uniqueness: { scope: :book_id }
end
