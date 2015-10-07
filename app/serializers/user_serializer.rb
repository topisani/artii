class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :avatar, :cover_picture
end
