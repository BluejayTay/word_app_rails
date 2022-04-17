# frozen_string_literal: true

class StudyList < ApplicationRecord
  belongs_to :user, optional: true
  has_and_belongs_to_many :words
  validates :title, presence: true, length: { in: 1..30 } 
  validates_uniqueness_of :title, scope: :user_id
  validates :high_score, numericality: { only_integer: true }, allow_blank: true

  def invalid_word_count?
    words.count.zero? || words.count > 10
  end
end
