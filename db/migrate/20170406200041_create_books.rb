class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :publisher
      t.string :isbn
      t.string :image
      t.text :description
      t.datetime :publish_date
      t.integer :page_count

      t.timestamps
    end
  end
end
