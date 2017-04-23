class RemoveTitleFromGift < ActiveRecord::Migration[5.0]
  def change
    remove_column :gifts, :title, :string
  end
end
