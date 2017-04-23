class RemoveAuthorFromGift < ActiveRecord::Migration[5.0]
  def change
    remove_column :gifts, :author, :string
  end
end
