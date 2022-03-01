class CreateStudyLists < ActiveRecord::Migration[6.1]
  def change
    create_table :study_lists do |t|
      t.string :title
      t.integer :high_score
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
