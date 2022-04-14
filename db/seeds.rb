# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
StudyList.destroy_all
Word.destroy_all
Synonym.destroy_all

beginner_list = StudyList.create({ title: 'Beginner Blurbs' })
beginner_words = ["hot", "cold", "big", "small", "happy", "sad", "near", "far", "empty", "full"]
beginner_words.each do |word|
  result = ThesaurusService.look_up(word)
  new_word = Word.create!(name: word, definition: result['shortdef'].join('; ').to_s)
  beginner_list.words << new_word
  synonyms_result = result['meta']['syns'][0]
  synonyms_result.each do |synonym|
    new_or_databased_synonym = Synonym.find_or_create_by!(name: synonym)
    new_word.synonyms << new_or_databased_synonym
  end
end

crossword_list = StudyList.create({ title: 'Crossword Commodities' })
crossword_words = ["ante", "bane", "cabal", "dyad", "haft", "icon", "iota", "meld", "onus", "skew"]
crossword_words.each do |word|
  result = ThesaurusService.look_up(word)
  new_word = Word.create!(name: word definition: result['shortdef'].join('; ').to_s)
  crossword_list.words << new_word
  synonyms_result = result['meta']['syns'][0]
  synonyms_result.each do |synonym|
    new_or_databased_synonym = Synonym.find_or_create_by!(name: synonym)
    new_word.synonyms << new_or_databased_synonym
  end
end

ivy_list = StudyList.create({ title: 'Ivy League Idiums' })
ivy_words = ["abate", "abjure", "benevolent", "deplore", "ephemeral", "gregarious", "lilliputian", "perfidious", "rancorous", "venerable"]
ivy_words.each do |word|
  result = ThesaurusService.look_up(word)
  new_word = Word.create!(name: word, definition: result['shortdef'].join('; ').to_s)
  ivy_list.words << new_word
  synonyms_result = result['meta']['syns'][0]
  synonyms_result.each do |synonym|
    new_or_databased_synonym = Synonym.find_or_create_by!(name: synonym)
    new_word.synonyms << new_or_databased_synonym
  end
end
