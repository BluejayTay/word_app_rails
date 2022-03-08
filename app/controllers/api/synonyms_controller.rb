class Api::SynonymsController < ApplicationController

  def index # GET api/words/:word_id/synonyms
    render json: {
      word: word,
      synonyms: synonyms
    }
  end
  
  private
  def word
    Word.find(params[:word_id])
  end

  def synonyms
    word.synonyms
  end

end
