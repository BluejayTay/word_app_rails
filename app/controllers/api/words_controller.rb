class Api::WordsController < ApplicationController
  
  def search #GET api/words/search
    word_query = params[:name]

    if word_query.present?
      @word = ThesaurusService.look_up(word_query)
      
      render json: {
        name: @word['meta']['id'],
        definition: @word['shortdef'],
        synonyms: @word['meta']['syns'][0]
      }
    end
  end
  
  def index # GET api/study_lists/:study_list_id/words'
    render json: {
      study_list: study_list,
      words: words
    }
  end
  
  private


  def study_list
    @study_list ||= StudyList.find(params[:study_list_id])
  end

  def words
    study_list.words
  end

end
