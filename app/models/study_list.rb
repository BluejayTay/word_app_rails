class StudyList < ApplicationRecord
  belongs_to :user, optional: true
  has_and_belongs_to_many :words
  validates :title, presence: true, length: {minimum: 1, maximum: 50}
  validates :high_score, numericality: { only_integer: true }, allow_blank: true

  def word_count
    self.words.count
  end
  
  def invalid_word_count?
    word_count == 0 || word_count > 10
  end
end
