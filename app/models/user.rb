class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :comments
  before_create :add_hash_for_url
  validates :name, uniqueness: true, allow_blank: true

  def add_hash_for_url
    self.hash_for_url = Sysrandom.hex(32)
  end
end
