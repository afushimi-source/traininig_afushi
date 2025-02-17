class Label < ApplicationRecord
  has_many :task_labels
  has_many :tasks, through: :task_labels

  validates :name, presence: true, length: { maximum: 15 }, uniqueness: true
end
