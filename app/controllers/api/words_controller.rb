class Api::WordsController < ApplicationController
  
  # def search #GET api/words/search
  #   word_query = params[:name]

  #   if word_query.present?
  #     @word = ThesaurusService.look_up(word_query)
      
  #     render json: {
  #       name: @word['meta']['id'],
  #       definition: @word['shortdef'],
  #       synonyms: @word['meta']['syns'][0]
  #     }
  #   end
  # end

  # def show
  #   @word = Word.find(id: params["id"])

  #   render json: {
  #     word: WordSerializer.new(word),
  #     synonyms: @word.synonyms }
  # end 

end
