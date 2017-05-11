class CreateReadingBookActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :reading_book_activities do |t|

      t.timestamps
    end
  end
end
