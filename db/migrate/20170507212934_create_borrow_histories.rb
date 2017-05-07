class CreateBorrowHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :borrow_histories do |t|
      t.string :user_book
      t.string :references
      t.references :user, foreign_key: true
      t.string :user_name
      t.string :user_surname
      t.references :borrow_history_state, foreign_key: true

      t.timestamps
    end
  end
end
