class CreateGifts < ActiveRecord::Migration[5.0]
  def change
    create_table :gifts do |t|
      t.references :book, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :reserved
      t.string :title
      t.string :author
      t.string :isbn

      t.timestamps
    end
  end
end
