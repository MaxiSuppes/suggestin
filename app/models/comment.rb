class Comment < ApplicationRecord
  belongs_to :user
  validates :content, presence: true
  validates :rating, presence: true
  validates :category, presence: true
end
