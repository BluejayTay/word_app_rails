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

StudyList.create!([{
  title: "Beginner Bitties"
},
{
  title: "Crossword Commodities"
},
{
  title: "Ivy League Locutions"
}])

Beginner_words = ["Hot", "Cold", "Big", "Small", "Happy", "Sad", "Near", "Far", "Empty", "Full"]
Beginner_words.each do |word|
  result = ThesaurusService.look_up(word)
  created_word = Word.create!(name: result['meta']['id'], definition: result['shortdef'].join("; ").to_s)
  StudyList.first.words << created_word
  synonyms = result['meta']['syns'][0]
  synonyms.each do |synonym|
    if Synonym.find_by(name: synonym)
      synonym_to_add = Synonym.find_by(name: synonym.to_s)
      created_word.synonyms << synonym_to_add
    else
      created_synonym = Synonym.create!(name: synonym.to_s)
      created_word.synonyms << created_synonym
    end
  end
end

Crossword_words = ["Ante", "Bane", "Cabal", "Dyad", "Haft", "Icon", "Iota", "Meld", "Onus", "Skew"]
Crossword_words.each do |word|
  result = ThesaurusService.look_up(word)
  created_word = Word.create!(name: result['meta']['id'], definition: result['shortdef'].join("; ").to_s)
  StudyList.second.words << created_word
  synonyms = result['meta']['syns'][0]
  synonyms.each do |synonym|
    if Synonym.find_by(name: synonym)
      synonym_to_add = Synonym.find_by(name: synonym.to_s)
      created_word.synonyms << synonym_to_add
    else
      created_synonym = Synonym.create!(name: synonym.to_s)
      created_word.synonyms << created_synonym
    end
  end
end

Ivy_words = ["Abate", "Abjure", "Benevolent", "Deplore", "Ephemeral", "Gregarious", "Lilliputian", "Perfidious", "Rancorous", "Venerable"]
Ivy_words.each do |word|
  result = ThesaurusService.look_up(word)
  created_word = Word.create!(name: result['meta']['id'], definition: result['shortdef'].join("; ").to_s)
  StudyList.third.words << created_word
  synonyms = result['meta']['syns'][0]
  synonyms.each do |synonym|
    if Synonym.find_by(name: synonym)
      synonym_to_add = Synonym.find_by(name: synonym.to_s)
      created_word.synonyms << synonym_to_add
    else
      created_synonym = Synonym.create!(name: synonym.to_s)
      created_word.synonyms << created_synonym
    end
  end
end