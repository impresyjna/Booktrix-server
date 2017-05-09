class BorrowHistorySerializer < ActiveModel::Serializer
  attributes :id, :user_book, :user_name, :user_surname, :borrow_history_state

  def user_book
    UserBookSerializer.new(object.user_book, { root: false } )
  end

  def borrow_history_state
    object.borrow_history_state.borrow_history_state_trans
  end

end
