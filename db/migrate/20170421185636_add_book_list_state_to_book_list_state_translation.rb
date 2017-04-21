class AddBookListStateToBookListStateTranslation < ActiveRecord::Migration[5.0]
  def change
    add_reference :book_list_state_translations, :book_list_state, foreign_key: true
  end
end
