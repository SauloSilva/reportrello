class Task < ActiveRecord::Base
  validates :name, :environment, presence: true
  validates :name, uniqueness: { scope: :environment_id }
  validates :name, length: { in: 6..100 }

  has_many :checklists, dependent: :destroy
  belongs_to :environment
end