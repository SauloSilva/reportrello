class Report < ActiveRecord::Base
  validates :name, :description, presence: true
  validates :name, length: { in: 6..100 }
  validates :description, length: { in: 6..255 }

  belongs_to :user
  has_many :environments, dependent: :destroy

  scope :not_reported, -> { where(reported_at: nil) }
  scope :by_user, -> (user_id) { where(user_id: user_id) }

  accepts_nested_attributes_for :environments, allow_destroy: true

  def warning?
    status == 'warning'
  end

  def success?
    status == 'success'
  end
end