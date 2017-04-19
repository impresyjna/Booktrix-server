class CreateBookListStates < ActiveRecord::Migration[5.0]
  def change
    create_table :book_list_states do |t|
      t.string :name
      t.string :country

      t.timestamps
    end
  end
end
