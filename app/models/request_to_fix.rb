class RequestToFix < ApplicationRecord
  belongs_to :user
  belongs_to :book
end
