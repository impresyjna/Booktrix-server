class FriendsActivity < ApplicationRecord
  acts_as :activity
  belongs_to :user, :foreign_key => 'friend_id'
end
