class Api::StudyListsController < ApplicationController
  before_action :authenticate_request!, except: [:new_game, :index, :update]
  before_action :set_list, only: [:new_game, :show, :update, :destroy]
  before_action :validate_params, only: :create

  def new_game # GET api/study_lists/:id/new_game
    @game_synonyms = []
    
    words.each do |word|
      synonyms = word.synonyms
      synonym_count = synonyms.count
      synonyms.each_with_index do |synonym, index|
        @game_synonym = synonyms[(rand(synonym_count))]
      end
      @game_synonyms << @game_synonym
    end
      
    render json: {
      study_list: StudyListSerializer.new(@study_list),
      words: words.map {|word| {id: word.id, name: word.name, definition: word.definition, match_index: words.index(word)}},
      synonyms: @game_synonyms.map {|synonym| {id: synonym.id, name: synonym.name, match_index: (@game_synonyms.index(synonym))}}
    }
  end
    
  def index # GET api/study_lists
    if payload
      load_current_user!
      @study_lists = base_study_lists + user_study_lists
    else 
      @study_lists = base_study_lists
    end

    render json: @study_lists
  end
  
  def show # GET api/study_lists/:id
    render json: { 
      study_list: StudyListSerializer.new(@study_list),
      words: words.map {|word| WordSerializer.new(word)}
    }
  end
  
  def create # POST api/study_lists
    @study_list = StudyList.create(study_list_params)

    if submitted_words
      submitted_words.each do |word|
        if Word.find_by(name: word)
          databased_word = Word.find_by(name: word)
          words << databased_word 
        elsif result = ThesaurusService.look_up(word)
          new_word = Word.create!(name: result['meta']['id'], definition: result['shortdef'].join("; ").to_s)
          words << new_word
          synonyms_result = result['meta']['syns'][0]
          synonyms_result.each do |synonym|
            new_or_databased_synonym = Synonym.find_or_create_by!(name: synonym)
            new_word.synonyms << new_or_databased_synonym
          end
        else next
        end
      end 
    end

    render json: {study_list: {title: @study_list.title, words: words}}
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

  def user_study_lists
    StudyList.all.where(user_id: @current_user.id)
  end

  def base_study_lists
    StudyList.all.where(user_id: nil).order(title: :asc)
  end

  def study_list_params
    params.require(:study_list).permit(:title, :high_score, :user_id)
  end

  def words
    @study_list.words
  end

  def set_list
    @study_list = StudyList.find(params[:id])
  end

  def submitted_words
    params[:words]
  end

  def validate_params
    raise if submitted_words.empty? || (submitted_words.length > 10) || (params[:study_list][:title].blank?)
  end
end