# frozen_string_literal: true

class ThesaurusService
  def self.look_up(word_query)
    result = HTTParty.get("https://dictionaryapi.com/api/v3/references/thesaurus/json/#{word_query}?key=#{ENV['MW_thesaurus_api_key']}")[0]

    if result.nil? || !result.is_a?(Hash)
      'Error: Word not found'
    else
      result
    end
  end
end
