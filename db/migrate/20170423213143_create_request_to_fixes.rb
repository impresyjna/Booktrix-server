class CreateRequestToFixes < ActiveRecord::Migration[5.0]
  def change
    create_table :request_to_fixes do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.text :notice

      t.timestamps
    end
  end
end
