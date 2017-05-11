class CreateAddToLibraryActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :add_to_library_activities do |t|

      t.timestamps
    end
  end
end
