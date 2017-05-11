class CreateFinishedReadingActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :finished_reading_activities do |t|

      t.timestamps
    end
  end
end
