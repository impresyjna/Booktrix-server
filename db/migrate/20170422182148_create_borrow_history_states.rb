class CreateBorrowHistoryStates < ActiveRecord::Migration[5.0]
  def change
    create_table :borrow_history_states do |t|
      t.integer :state

      t.timestamps
    end
  end
end
