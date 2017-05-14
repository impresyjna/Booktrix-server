class PostCommentSerializer < ActiveModel::Serializer
  attributes :id, :user, :content

  def user
    FriendSerializer.new(object.user, { root: false} )
  end
end
