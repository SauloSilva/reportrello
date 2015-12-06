class Task < ActiveRecord::Base
  validates :name, :report, presence: true
  validates :name, uniqueness: { scope: :report_id }
  validates :name, length: { in: 6..100 }

  has_many :checklists, dependent: :destroy
  belongs_to :report
end