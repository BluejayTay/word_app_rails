# frozen_string_literal: true

class ChangeColumnNullUserStudyList < ActiveRecord::Migration[6.1]
  def change
    change_column :study_lists, :user_id, :bigint, null: true
  end
end
