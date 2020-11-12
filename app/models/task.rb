class Task < ApplicationRecord
  validates :task_title, presence: true
end
