class Api::WordsController < ApplicationController
  
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
