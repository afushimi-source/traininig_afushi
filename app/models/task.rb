class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30 }
  validates :description, length: { maximum: 600 }

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

  def self.search(title_term, status_term, priority_term)
    return Task.all unless title_term || status_term || priority_term
    status_term = Task.statuses.keys.include?(status_term) ? Task.statuses[status_term] : nil
    priority_term = Task.priorities.keys.include?(priority_term) ? Task.priorities[priority_term] : nil

    return Task.where('title LIKE ?', "%#{title_term}%") if status_term.nil?

    Task.where('title LIKE ? AND status = ?', "%#{title_term}%", status_term)
  end
end
