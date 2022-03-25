class StudyList < ApplicationRecord
  belongs_to :user, optional: true
  has_and_belongs_to_many :words
  validates :title, presence: true, length: {minimum: 1, maximum: 50}
  validate :valid_word_count
  
  def word_count
    self.words.count
  end

  def valid_word_count
    if self.words.count > 10
      errors.add(:word_count, "Must be less than or equal to 10")
    end
  end

end
