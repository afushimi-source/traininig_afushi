class Label < ApplicationRecord
  validates :name, presence: true, length: { maximum: 15 }, uniqueness: true
end
