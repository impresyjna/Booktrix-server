class CreateBookLists < ActiveRecord::Migration[5.0]
  def change
    create_table :book_lists do |t|
      t.references :book, foreign_key: true
      t.references :user, foreign_key: true
      t.references :book_list_state, foreign_key: true

      t.timestamps
    end
  end
end
