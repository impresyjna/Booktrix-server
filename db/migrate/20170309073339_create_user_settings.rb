class CreateUserSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :user_settings do |t|
      t.boolean :show_full_name, default: false
      t.boolean :show_gifts_boolean, default: false
      t.boolean :show_activities, default: false
      t.boolean :show_books, default: false

      t.timestamps
    end
  end
end
