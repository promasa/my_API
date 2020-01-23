class PostSerializer < ActiveModel::Serializer
  attributes :id,
              :text,
              :user,
              :created_at,
              :updated_at

  def user
    user = User.where(id: object.user_id).first
    UserSerializer.new(user)
  end
end


