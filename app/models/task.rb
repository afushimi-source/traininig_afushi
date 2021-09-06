class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30 }
  validates :description, length: { maximum: 600 }

  scope :sort_column, ->(column, direction) { order("#{column} #{direction}") }
end
