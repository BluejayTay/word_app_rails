class ThesaurusService
  def self.look_up(word)
    HTTParty.get("https://dictionaryapi.com/api/v3/references/thesaurus/json/#{word}?key=#{ENV['MW_thesaurus_api_key']}")[0]
  end
end