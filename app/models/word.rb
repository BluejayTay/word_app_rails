# frozen_string_literal: true

class Word < ApplicationRecord
  has_and_belongs_to_many :synonyms
  has_and_belongs_to_many :study_lists
  validates_uniqueness_of :name
  validates :definition, presence: true
  validates :name, presence: true
end
