# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :study_lists
  validates :email, presence: true, uniqueness: true
  before_validation :normalize_email
  validates :password_digest, presence: true
  validates :password, length: { in: 6..50 }, on: :create

  def normalize_email
    self.email = self.email.downcase.strip
  end

end
