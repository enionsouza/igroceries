class User < ApplicationRecord
  has_many :groups
  has_many :groceries, foreign_key: :author_id
end
