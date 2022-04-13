# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :study_lists
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: { in: 6..50 }, on: :create
end
