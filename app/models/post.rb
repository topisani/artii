class Post < ActiveRecord::Base
  belongs_to :artworks
  belongs_to :user
  has_many :pictures, through: :post_pictures

  validates :user, presence: true
end
