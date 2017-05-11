class AddFieldsToActivity < ActiveRecord::Migration[5.0]
  def change
    change_table :activities do |t|
      t.actable
    end
  end
end
