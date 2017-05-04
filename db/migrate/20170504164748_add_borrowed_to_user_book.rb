class AddBorrowedToUserBook < ActiveRecord::Migration[5.0]
  def change
    add_column :user_books, :borrowed, :boolean, default: false
  end
end
