class Artwork < ActiveRecord::Base
  belongs_to :user
  has_many :posts
  has_many :artwork_pictures
  has_many :pictures, through: :artwork_pictures

  validates :user, presence: true
end
