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

  scope :search, lambda { |title_term, status_term, priority_term|
    status_term = Task.statuses.keys.include?(status_term) ? Task.statuses[status_term] : nil
    priority_term = Task.priorities.keys.include?(priority_term) ? Task.priorities[priority_term] : nil
    return unless title_term || status_term || priority_term

    title_like(title_term).search_status(status_term).search_priority(priority_term)
  }

  scope :title_like, ->(title_term) { where('title LIKE ?', "%#{title_term}%") if title_term.present? }

  scope :search_status, ->(status_term) { where('status = ?', status_term) if status_term.present? }

  scope :search_priority, ->(priority_term) { where('priority = ?', priority_term) if priority_term.present? }

  scope :sort_deadline_on, lambda { |sort_deadline_on|
    return if sort_deadline_on.nil?

    sort_deadline_on == 'asc' ? order(deadline_on: :asc) : order(deadline_on: :desc)
  }

  scope :sort_priority, lambda { |sort_priority|
    return order(created_at: :desc) if sort_priority.nil?

    sort_priority == 'asc' ? order(priority: :asc) : order(priority: :desc)
  }
end
