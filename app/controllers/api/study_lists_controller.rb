class Api::StudyListsController < ApplicationController
  before_action :authenticate_request!, except: [:new_game, :index]
  before_action :load_current_user!
  before_action :set_list, only: [:new_game, :show, :update, :destroy]
  def new_game # GET api/study_lists/:id/new_game
    game_synonyms = []
    
    (@study_list.words).each do |word|
      #@match_index = @study_list.words.index(word)
      (word.synonyms).each_with_index do |synonym, index|
        @game_synonym = (word.synonyms)[(rand((word.synonyms).count))]
      end
      game_synonyms << @game_synonym
    end
      
    render json: {
      title: @study_list.title,
      words: (@study_list.words).map {|word| WordSerializer.new(word)},
      synonyms: game_synonyms.map {|synonym| SynonymSerializer.new(synonym)}
    }
  end

  def add_words # POST api/study_lists/:id/words
    @study_list = StudyList.find(params[:id])
    words = params[:words].split()
    words.each do |word|
      if Word.find_by(name: word)
        word_to_add = Word.find_by(name: word)
        @study_list.words << word_to_add 
      else
        result = ThesaurusService.look_up(word)
        created_word = Word.create!(name: result['meta']['id'], definition: result['shortdef'].join("; ").to_s)
        @study_list.words << created_word
        synonyms = result['meta']['syns'][0]
        synonyms.each do |synonym|
          if Synonym.find_by(name: synonym)
            synonym_to_add = Synonym.find_by(name: synonym.to_s)
            created_word.synonyms << synonym_to_add
          else
            created_synonym = Synonym.create!(name: synonym.to_s)
            created_word.synonyms << created_synonym
          end
        end
      end
    end
    render json: {
      study_list: @study_list,
      added_word: @study_list.words
    }
  end
    
  def index # GET api/study_lists
    @current_user.nil? ? study_lists = base_study_lists : study_lists = (@current_user.study_lists + base_study_lists)
    
    render json: study_lists
  end
  
  def show # GET api/study_lists/:id
    render json: @study_list
  end
  
  def create # POST api/study_lists
    user = @current_user
    
    study_list = StudyList.create(study_list_params)
    study_list.user_id = user.id
    if study_list.save
      render json: study_list
    else
      render json: study_list.errors, status: :unprocessable_entity
    end
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
    params.permit(:title, :high_score)
  end

  def set_list
    @study_list = StudyList.find(params[:id])
  end
end
