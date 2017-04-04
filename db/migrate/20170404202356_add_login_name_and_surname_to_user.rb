class AddLoginNameAndSurnameToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :login, :string
    add_column :users, :name, :string
    add_column :users, :surname, :string
  end
end
