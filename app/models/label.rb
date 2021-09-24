class Label < ApplicationRecord
  has_many :label_maps
  has_many :tasks, through: :label_maps

  validates :name, presence: true, length: { maximum: 15 }, uniqueness: true
end
