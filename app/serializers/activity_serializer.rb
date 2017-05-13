class ActivitySerializer < ActiveModel::Serializer
  attributes :id, :user, :book, :friend, :mark

  def user
    FriendSerializer.new(object.user, {root: false} )
  end

  def book
    if object.actable_type == "BookActivity"
      ActivityBookSerializer.new(BookActivity.find(object.actable_id).book, { root: false } )
    end
  end

  def friend
    if object.actable_type == "FriendsActivity"
      FriendSerializer.new(FriendsActivity.find(object.actable_id).user, { root: false} )
    end
  end

  def mark
    if object.actable_type == "BookActivity"
      book_activity = BookActivity.find(object.actable_id)
      if book_activity.actable_type == "MarkActivity"
        MarkActivity.find(book_activity.actable_id).mark.value
      end
    end
  end
end
