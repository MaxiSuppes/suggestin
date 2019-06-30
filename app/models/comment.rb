class Comment < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  validates :content, presence: true
  validates :rating, presence: true
  validates :category, presence: true
end
