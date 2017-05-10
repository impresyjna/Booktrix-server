class CreateBookActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :book_activities do |t|
      t.references :book, foreign_key: true

      t.timestamps
    end
  end
end
