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

StudyList.create!(study_list: {title: "Beginner Blurbs"}, words: ["Hot", "Cold", "Big", "Small", "Happy", "Sad", "Near", "Far", "Empty", "Full"])
  #{study_list: {title: "Crossword Commodities"}, words: ["Ante", "Bane", "Cabal", "Dyad", "Haft", "Icon", "Iota", "Meld", "Onus", "Skew"]},
  #{study_list: {title: "Ivy League Locutions"}, words: ["Abate", "Abjure", "Benevolent", "Deplore", "Ephemeral", "Gregarious", "Lilliputian", "Perfidious", "Rancorous", "Venerable"]},])