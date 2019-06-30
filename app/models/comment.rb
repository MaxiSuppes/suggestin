class Comment < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  validates :content, presence: true
  validates :rating, presence: true
  validates :category, presence: true

  def comment_image
    image.variant(resize: '400x300', rotate: '90', auto_orient: true)
  end
end
