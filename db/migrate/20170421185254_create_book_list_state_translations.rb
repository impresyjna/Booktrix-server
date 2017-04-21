class CreateBookListStateTranslations < ActiveRecord::Migration[5.0]
  def change
    create_table :book_list_state_translations do |t|
      t.string :country
      t.string :translation

      t.timestamps
    end
  end
end
