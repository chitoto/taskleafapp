class Task < ApplicationRecord
  validates :task_title, presence: true
  validates :task_description, presence: true
end
