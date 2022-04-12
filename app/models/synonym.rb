# frozen_string_literal: true

class Synonym < ApplicationRecord
  has_and_belongs_to_many :words
  validates_uniqueness_of :name
  validates :name, presence: true
end
