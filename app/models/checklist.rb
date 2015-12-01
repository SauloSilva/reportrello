class Checklist < ActiveRecord::Base
  validates :description, :task, presence: true
  validates :description, length: { in: 6..255 }

  belongs_to :task
end