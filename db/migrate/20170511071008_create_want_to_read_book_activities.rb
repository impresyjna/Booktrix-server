class CreateWantToReadBookActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :want_to_read_book_activities do |t|

      t.timestamps
    end
  end
end
