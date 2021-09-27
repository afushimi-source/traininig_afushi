class Task < ApplicationRecord
  enum status: {
    未着手: 0,
    着手中: 1,
    完了: 2
  }

  enum priority: {
    低: 0,
    中: 1,
    高: 2
  }

  belongs_to :user

  validates :title, presence: true, length: { maximum: 30 }
  validates :description, length: { maximum: 600 }

  scope :search, Tasks::SearchTermQuery

  scope :sort_column, Tasks::SortColumnQuery
end
