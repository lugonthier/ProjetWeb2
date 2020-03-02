class Post < ApplicationRecord
  belongs_to :user
  has_image :photo, resize: '600x300', formats: {
    thumb: '150x150'
  }


  validates :name, :content, presence: true
  validates :photo_file, presence: true, on: :create
  
end
