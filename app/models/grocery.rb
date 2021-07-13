class Grocery < ApplicationRecord
  belongs_to :author, class_name: 'User'

  has_and_belongs_to_many :groups

  validates :name, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
