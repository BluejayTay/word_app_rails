# frozen_string_literal: true

class WordSerializer < ActiveModel::Serializer
  attributes :id, :name, :definition
end
