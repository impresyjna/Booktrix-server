class AddFieldsToBorrow < ActiveRecord::Migration[5.0]
  def change
    add_column :borrows, :user_name, :string
    add_column :borrows, :user_surname, :string
    add_reference :borrows, :borrow_history_state, foreign_key: true
  end
end
