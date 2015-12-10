class Environment < ActiveRecord::Base
  validates :name, :board_name, :list_name, :checklist_name, presence: true

  belongs_to :report
  has_many :tasks, dependent: :destroy
end