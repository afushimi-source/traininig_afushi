class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30 }
  validates :description, length: { maximum: 600 }

  enum status: {
    未着手: 0,
    着手中: 1,
    完了: 2
  }

  scope :search, lambda { |title_term, status_term|
    status_term = Task.statuses.keys.include?(status_term) ? Task.statuses[status_term] : nil
    return unless title_term || status_term

    title_like(title_term).search_status(status_term)
  }

  scope :title_like, ->(title_term) { where('title LIKE ?', "%#{title_term}%") if title_term.present? }

  scope :search_status, ->(status_term) { where('status = ?', status_term) if status_term.present? }

  scope :sort_deadline_on, lambda { |sort_deadline_on|
    return order(created_at: :desc) if sort_deadline_on.nil?

    sort_deadline_on == 'asc' ? order(deadline_on: :asc) : order(deadline_on: :desc)
  }
end
