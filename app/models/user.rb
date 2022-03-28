class User < ApplicationRecord
  validates :name, presence: true, length: {maximum: 5}
  has_many :posts, dependent: :destroy
end
