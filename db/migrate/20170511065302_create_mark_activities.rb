class CreateMarkActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :mark_activities do |t|
      t.references :mark, foreign_key: true

      t.timestamps
    end
  end
end
