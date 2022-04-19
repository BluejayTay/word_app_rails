class WordCreator
  
  def initialize(name, result)
    @name = name
    @result = result
  end

  def create!
    word = Word.create!(name: @name, definition: @result['shortdef'].join('; '))
    add_synonyms
    word
  end

  def add_synonyms
    new_word = Word.find_by(name: @name)

    synonyms_result = @result['meta']['syns'].flatten
    synonyms_result.each do |synonym|
      new_word.synonyms << Synonym.find_or_create_by!(name: synonym)
    end
  end
end