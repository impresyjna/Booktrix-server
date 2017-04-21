class RemoveCountryFromBookListState < ActiveRecord::Migration[5.0]
  def change
    remove_column :book_list_states, :country, :string
  end
end
