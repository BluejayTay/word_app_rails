class Word < ApplicationRecord
  has_and_belongs_to_many :synonyms
  has_and_belongs_to_many :study_lists
end
