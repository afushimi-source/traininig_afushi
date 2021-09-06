class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30 }
  validates :description, length: { maximum: 600 }

  enum priority: {
    低: 0,
    中: 1,
    高: 2
  }

  def self.search(term)
    return Task.all unless term

    sanitize_term = "%#{sanitize_sql_like(term)}%"
    Task.where('title LIKE ? OR status LIKE ?', sanitize_term, sanitize_term)
  end

  scope :sort_column, ->(column, direction) { order("#{column} #{direction}") }
end
