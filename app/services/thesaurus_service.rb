class ThesaurusService
  def self.look_up(word_query)
    HTTParty.get("https://dictionaryapi.com/api/v3/references/thesaurus/json/#{word_query}?key=#{ENV['MW_thesaurus_api_key']}")[0]
  end
end