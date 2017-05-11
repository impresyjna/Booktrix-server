class AddFieldsToBookActivity < ActiveRecord::Migration[5.0]
  def change
    change_table :book_activities do |t|
      t.actable
    end
  end
end
