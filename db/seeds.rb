# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#StudyList.destroy_all
#Word.destroy_all
#Synonym.destroy_all

beginner_list = StudyList.create({title: "Beginner Blurbs"}) 
beginner_words = ["Hot", "Cold", "Big", "Small", "Happy", "Sad", "Near", "Far", "Empty", "Full"]
beginner_words.each do |word|
  result = ThesaurusService.look_up(word)
  new_word = Word.create!(name: result['meta']['id'], definition: result['shortdef'].join("; ").to_s)
  beginner_list.words << new_word
  synonyms_result = result['meta']['syns'][0]
  synonyms_result.each do |synonym|
    new_or_databased_synonym = Synonym.find_or_create_by!(name: synonym)
    new_word.synonyms << new_or_databased_synonym
    end
  end 

crossword_list = StudyList.create({title: "Crossword Commodities"}) 
crossword_words = ["Ante", "Bane", "Cabal", "Dyad", "Haft", "Icon", "Iota", "Meld", "Onus", "Skew"]
crossword_words.each do |word|
  result = ThesaurusService.look_up(word)
  new_word = Word.create!(name: result['meta']['id'], definition: result['shortdef'].join("; ").to_s)
  crossword_list.words << new_word
  synonyms_result = result['meta']['syns'][0]
  synonyms_result.each do |synonym|
    new_or_databased_synonym = Synonym.find_or_create_by!(name: synonym)
    new_word.synonyms << new_or_databased_synonym
    end
  end

ivy_list = StudyList.create({title: "Ivy League Idiums"}) 
ivy_words = ["Abate", "Abjure", "Benevolent", "Deplore", "Ephemeral", "Gregarious", "Lilliputian", "Perfidious", "Rancorous", "Venerable"]
ivy_words.each do |word|
  result = ThesaurusService.look_up(word)
  new_word = Word.create!(name: result['meta']['id'], definition: result['shortdef'].join("; ").to_s)
  ivy_list.words << new_word
  synonyms_result = result['meta']['syns'][0]
  synonyms_result.each do |synonym|
    new_or_databased_synonym = Synonym.find_or_create_by!(name: synonym)
    new_word.synonyms << new_or_databased_synonym
    end
  end