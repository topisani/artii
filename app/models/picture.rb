class Picture < ActiveRecord::Base
  belongs_to :user
  has_many :artwork_pictures
  has_many :post_pictures
  has_many :artworks, through: :artwork_pictures
  has_many :posts, through: :post_pictures


  mount_uploader :image, ImageUploader
  validates :user, presence: true
end
