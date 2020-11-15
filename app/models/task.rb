class Task < ApplicationRecord
  validates :task_title, presence: true
  validates :task_description, presence: true
  validates :status, inclusion: { in: %w(未着手 着手中 完了 "") }
end
