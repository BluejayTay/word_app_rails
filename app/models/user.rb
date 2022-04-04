class User < ApplicationRecord
  has_secure_password

  has_many :study_lists
  validates :email, presence: true, uniqueness: true, allow_blank: false
end
