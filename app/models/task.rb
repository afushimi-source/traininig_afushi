class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30 }
  validates :description, length: { maximum: 600 }

  enum status: {
    未着手: 0,
    着手中: 1,
    完了: 2
  }

  def self.search(title_term, status_term)
    return Task.all unless title_term || status_term

    status_term = Task.statuses.keys.include?(status_term) ? Task.statuses[status_term] : nil
    return Task.where('title LIKE ?', "%#{title_term}%") if status_term.nil?

    Task.where('title LIKE ? AND status = ?', "%#{title_term}%", status_term)
  end

  scope :sort_deadline_on, lambda { |sort_deadline_on|
    return order(created_at: :desc) if sort_deadline_on.nil?

    sort_deadline_on == 'asc' ? order(deadline_on: :asc) : order(deadline_on: :desc)
  }
end
