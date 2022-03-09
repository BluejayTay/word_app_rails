class AddIndexToStudyListsWords < ActiveRecord::Migration[6.1]
  def change
    add_index :study_lists_words, [:study_list_id, :word_id], unique: true
  end
end
