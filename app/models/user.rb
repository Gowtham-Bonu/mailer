class User < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates :name, :email, presence: true
  validates :email, uniqueness: true
end
