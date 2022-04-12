# frozen_string_literal: true

class CreateJoinTableSynonymWord < ActiveRecord::Migration[6.1]
  def change
    create_join_table :synonyms, :words do |t|
      # t.index [:synonym_id, :word_id]
      # t.index [:word_id, :synonym_id]
    end
  end
end
