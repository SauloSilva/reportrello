class Import < ActiveRecord::Base
  validates :board_name, :list_name, :checklist_name, :environment, presence: true

  has_many :reports
  belongs_to :user

  scope :not_imported, -> { where(imported_at: nil) }
end