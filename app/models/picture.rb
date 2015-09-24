class Picture < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  belongs_to :artwork

  mount_uploader :image, ImageUploader

  validates :user, presence: true
end
