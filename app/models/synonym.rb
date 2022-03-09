class Synonym < ApplicationRecord
  has_and_belongs_to_many :words
  validates_uniqueness_of :name
end
