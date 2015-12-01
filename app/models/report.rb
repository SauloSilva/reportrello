class Report < ActiveRecord::Base
  validates :name, :description, presence: true
  validates :name, length: { in: 6..100 }
  validates :description, length: { in: 6..255 }

  has_many :tasks
  belongs_to :import
end