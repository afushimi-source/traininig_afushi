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

  def self.search(searchs)
    return Task.all if searchs.empty?

    searchs[:status] = Task.statuses.keys.include?(searchs[:status]) ? Task.statuses[searchs[:status]] : nil
    searchs[:priority] = Task.priorities.keys.include?(searchs[:priority]) ? Task.priorities[searchs[:priority]] : nil

    # return Task.where('title LIKE ?', "%#{searchs[:title]}%") if seastatus.nil?
    Task.all

    # Task.where('title LIKE ? AND status = ?', "%#{title}%", status)
  end
end
