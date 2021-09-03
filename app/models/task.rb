class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30 }
  validates :description, length: { maximum: 600 }

  def self.search(term)
    return Task.all unless term
    return Task.where('title LIKE ? OR status LIKE ?', "#{sanitize_sql_like(term)}", "#{sanitize_sql_like(term)}")
  end
end
