class CreateBorroweds < ActiveRecord::Migration[5.0]
  def change
    create_table :borroweds do |t|
      t.references :user_book, foreign_key: true
      t.references :user, foreign_key: true
      t.string :user_name
      t.string :user_surname
      t.references :state, foreign_key: true

      t.timestamps
    end
  end
end
