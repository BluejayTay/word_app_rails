# frozen_string_literal: true

class ThesaurusService
  def self.look_up(word_query)
    response = HTTParty.get("https://dictionaryapi.com/api/v3/references/thesaurus/json/#{word_query}?key=#{ENV['MW_thesaurus_api_key']}")[0]
    if response.nil? || response.is_a?(String)
      return 'Error: Word not found'
    else
      return response
    end
  end
end