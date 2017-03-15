class CreateUserSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :user_settings do |t|
      t.boolean :show_full_name
      t.string :show_gifts_boolean
      t.boolean :show_activities
      t.boolean :show_books

      t.timestamps
    end
  end
end
