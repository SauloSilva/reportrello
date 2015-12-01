class User < ActiveRecord::Base
  validates :token, :username, :fullname, presence: true
  validates :token, uniqueness: true

  has_many :tasks
end