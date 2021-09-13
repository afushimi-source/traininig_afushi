class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30 }
  validates :description, length: { maximum: 600 }

  def self.search(title_term, status_term)
    return Task.all unless title_term && status_term

    sanitize_term = "%#{sanitize_sql_like(title_term)}%"
    Task.where('title LIKE ? OR status = ?', title_term, status_term)
  end

  scope :sort_column, ->(column, direction) { order("#{column} #{direction}") }
end
