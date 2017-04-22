class CreateBorrowHistoryStateTrans < ActiveRecord::Migration[5.0]
  def change
    create_table :borrow_history_state_trans do |t|
      t.string :translation
      t.string :country
      t.references :borrow_history_state, foreign_key: true

      t.timestamps
    end
  end
end
