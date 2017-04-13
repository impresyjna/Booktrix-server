class AddPublisherCityToBook < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :publisher_city, :string
  end
end
