class RemoveIsbnFromGift < ActiveRecord::Migration[5.0]
  def change
    remove_column :gifts, :isbn, :string
  end
end
