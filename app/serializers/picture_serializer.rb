class PictureSerializer < ActiveModel::Serializer
  attributes :id, :name, :created_at, :user, :image
  def user
    {id: object.user.id}
  end
  def image
    {url: object.image.url()}
  end
end
