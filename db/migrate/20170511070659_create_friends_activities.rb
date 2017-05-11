class CreateFriendsActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :friends_activities do |t|
      t.integer :friend_id

      t.timestamps
    end
  end
end
