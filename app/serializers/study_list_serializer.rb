# frozen_string_literal: true

class StudyListSerializer < ActiveModel::Serializer
  attributes :id, :title, :high_score, :user_id
end
