class CreateJoinTableStudyListWord < ActiveRecord::Migration[6.1]
  def change
    create_join_table :study_lists, :words do |t|
      # t.index [:study_list_id, :word_id]
      # t.index [:word_id, :study_list_id]
    end
  end
end
