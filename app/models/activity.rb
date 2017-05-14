class Activity < ApplicationRecord
  actable
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :post_comments, dependent: :destroy
end
