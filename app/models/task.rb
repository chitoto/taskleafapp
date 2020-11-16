class Task < ApplicationRecord
  validates :task_title, presence: true
  validates :task_description, presence: true
  validates :status, inclusion: { in: %w(未着手 着手中 完了 "") }

  scope :search_by_title, -> (title_key){where('task_title LIKE ?', "%#{title_key}%")}
  scope :search_by_status, -> (seach_status){where('status = ?', "#{seach_status}")}
end
