class Comment < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  validates :content, presence: true
  validates :rating, presence: true
  validates :category, presence: true

  scope :by_category, ->(category) {
    where(category: category)
  }
end
