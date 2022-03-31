class Api::StudyListsController < ApplicationController
  before_action :authenticate_request!, except: [:new_game, :index]
  before_action :set_list, only: [:new_game, :show, :update, :destroy]
  
  def new_game # GET api/study_lists/:id/new_game
    @game_synonyms = []
    
    (@study_list.words).each do |word|
      synonym_count = word.synonyms.count
      (word.synonyms).each_with_index do |synonym, index|
        @game_synonym = (word.synonyms)[(rand(synonym_count))]
      end
      @game_synonyms << @game_synonym
    end
      
    render json: {
      study_list: StudyListSerializer.new(@study_list),
      words: (@study_list.words).map {|word| {id: word.id, name: word.name, definition: word.definition, match_index: (@study_list.words).index(word)}},
      synonyms: @game_synonyms.map {|synonym| {id: synonym.id, name: synonym.name, match_index: (@game_synonyms.index(synonym))}}
    }
  end
    
  def index # GET api/study_lists
    @study_lists = base_study_lists
    render json: @study_lists
  end
  
  def show # GET api/study_lists/:id
    render json: @study_list
  end
  
  def create # POST api/study_lists
    @study_list = StudyList.create(study_list_params)
    words = params[:words]
    words.each do |word|
      if Word.find_by(name: word)
        word_to_add = Word.find_by(name: word)
        @study_list.words << word_to_add 
      elsif result = ThesaurusService.look_up(word)
        created_word = Word.create!(name: result['meta']['id'], definition: result['shortdef'].join("; ").to_s)
        @study_list.words << created_word
        synonyms = result['meta']['syns'][0]
        synonyms.each do |synonym|
          synonym_to_add = Synonym.find_or_create_by!(name: synonym)
          created_word.synonyms << synonym_to_add
        end
      else next
      end
    end

    render JSON: {study_list: {title: @study_list.title, words: @study_list.words}}
  end
  
  def update #PATCH/PUT api/study_lists/:id
    if @study_list.update(study_list_params)
      render json: @study_list
    else
      render json: @study_list.errors, status: :unprocessable_entity
    end
  end


  def destroy #DELETE api/study_lists/:id
    @study_list.destroy
  end

  private

  def base_study_lists
    StudyList.all.where(user_id: nil)
  end

  def study_list_params
    params.require(:study_list).permit(:title, :high_score, :user_id)
  end

  def set_list
    @study_list = StudyList.find(params[:id])
  end
end


#Parameters: {"title"=>"test", "words"=>["test", "word"], "study_list"=>{"title"=>"test"}}
#Parameters: {"study_list"=>{"title"=>"heloooooo"}, "words"=>["test", "world"]}