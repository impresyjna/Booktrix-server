class AddUserToUserSetting < ActiveRecord::Migration[5.0]
  def change
    add_reference :user_settings, :user, foreign_key: true
  end
end
