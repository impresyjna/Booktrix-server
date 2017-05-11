class CreateGiftAddActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :gift_add_activities do |t|

      t.timestamps
    end
  end
end
