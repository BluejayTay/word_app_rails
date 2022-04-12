# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_220_309_222_913) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'study_lists', force: :cascade do |t|
    t.string 'title'
    t.integer 'high_score'
    t.bigint 'user_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['user_id'], name: 'index_study_lists_on_user_id'
  end

  create_table 'study_lists_words', id: false, force: :cascade do |t|
    t.bigint 'study_list_id', null: false
    t.bigint 'word_id', null: false
    t.index %w[study_list_id word_id], name: 'index_study_lists_words_on_study_list_id_and_word_id', unique: true
  end

  create_table 'synonyms', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'synonyms_words', id: false, force: :cascade do |t|
    t.bigint 'synonym_id', null: false
    t.bigint 'word_id', null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email'
    t.string 'password_digest'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'words', force: :cascade do |t|
    t.string 'name'
    t.text 'definition'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  add_foreign_key 'study_lists', 'users'
end
