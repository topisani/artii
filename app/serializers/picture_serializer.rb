class PictureSerializer < ActiveModel::Serializer
  attributes :id, :name, :created_at, :user
  def user
    UserSerializer.new( object.user ).attributes
  end
end
