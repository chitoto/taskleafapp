class Task < ApplicationRecord
  belongs_to :user
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings

  validates :task_title, presence: true
  validates :task_description, presence: true
  validates :status, presence: true
  validates :priority, presence: true

  enum status: { 未着手: 0, 着手: 1, 完了: 2 }
  enum priority: { 低:0, 中:1, 高:2 }

  scope :search_title, -> (title_key){where('task_title LIKE ?', "%#{title_key}%")}
  scope :search_status, -> (seach_status){where('status = ?', "#{seach_status}")}
  scope :search_label, -> (label_id){ where(id: Labelling.where(label_id: label_id).pluck(:task_id)) }


end
