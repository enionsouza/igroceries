class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { in: 3..20 }

  has_many :groups
  has_many :groceries, foreign_key: :author_id
end
