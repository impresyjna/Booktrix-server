class ChangePublishDateInBook < ActiveRecord::Migration[5.0]
  def change
    change_column :books, :publish_date, :string
  end
end
