class Report < ActiveRecord::Base
  validates :name, :description, :board_name, :list_name, :checklist_name,
    :environment, presence: true
  validates :name, length: { in: 6..100 }
  validates :description, length: { in: 6..255 }

  belongs_to :user
  has_many :tasks

  scope :not_reported, -> { where(reported_at: nil) }
  scope :by_user, -> (user_id) { where(user_id: user_id) }
end