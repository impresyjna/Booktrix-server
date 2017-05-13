class Activity < ApplicationRecord
  actable
  belongs_to :user
  has_many :likes
  has_many :post_comments
end
