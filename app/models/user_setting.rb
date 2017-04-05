class UserSetting < ApplicationRecord
  belongs_to :user

  def init
    self.show_full_name  ||= false
    self.show_gifts_boolean ||= false
    self.show_activities ||= false
    self.show_books ||= false
  end

end
