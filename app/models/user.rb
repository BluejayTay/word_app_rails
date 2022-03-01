class User < ApplicationRecord
  has_secure_password
  has_many :study_lists
end
