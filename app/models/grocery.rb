class Grocery < ApplicationRecord
  belongs_to :author, class_name: 'User'

  has_and_belongs_to_many :groups
  accepts_nested_attributes_for :groups

  validates :name, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }

  scope :particular, -> { where(private: true) }
  scope :common, -> { where(private: [false, nil]) }
end
