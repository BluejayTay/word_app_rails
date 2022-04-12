# frozen_string_literal: true

class CreateWords < ActiveRecord::Migration[6.1]
  def change
    create_table :words do |t|
      t.string :name
      t.text :definition

      t.timestamps
    end
  end
end
