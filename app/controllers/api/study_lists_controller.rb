# frozen_string_literal: true

module Api
  class StudyListsController < ApplicationController
    before_action :authenticate_request!, only: :create
    before_action :set_list, only: %i[new_game update]

    def new_game
      @game_synonyms = []

      words.each do |word|
        synonyms = word.synonyms
        synonym_count = synonyms.count
        game_synonym = synonyms[(rand(synonym_count))]
        @game_synonyms << game_synonym
      end

      render json: {
        study_list: StudyListSerializer.new(@study_list),
        words: words_and_match_indices,
        synonyms: game_synonyms_and_match_indices
      }
    end

    def index
      study_lists = base_study_lists
      study_lists += user_study_lists if payload
      
      render json: study_lists
    end

    def create
      @study_list = StudyList.create(study_list_params)
      
      submitted_words.each do |word|
        name = word.downcase.delete(' ')

        existing_word = Word.find_by(name: name)
        if existing_word
          words << existing_word
        else
          result = ThesaurusService.look_up(name)
          next if result == 'Error: Word not found'
        
          new_word = WordCreator.new(name, result).create!
          words << new_word
        end
      end

      destroy_list_and_raise_error if @study_list.invalid_word_count?
      render json: { study_list: { title: @study_list.title, words: words } }
    end

    def update
      if @study_list.update(study_list_params)
        render json: @study_list
      else
        render json: @study_list.errors, status: :unprocessable_entity
      end
    end

    private

    def user_study_lists
      load_current_user!

      StudyList.all.where(user_id: @current_user.id)
    end

    def base_study_lists
      StudyList.all.where(user_id: nil).order(title: :asc)
    end

    def study_list_params
      params.require(:study_list).permit(:title, :high_score, :user_id)
    end

    def submitted_words
      params[:words]
    end

    def words
      @study_list.words
    end

    def set_list
      @study_list = StudyList.find(params[:id])
    end

    def destroy_list_and_raise_error
      @study_list.destroy

      raise
    end

    def words_and_match_indices
      words.map do |word|
        { id: word.id, name: word.name, definition: word.definition, match_index: words.index(word) }
      end
    end

    def game_synonyms_and_match_indices
      @game_synonyms.map do |synonym|
        { id: synonym.id, name: synonym.name, match_index: @game_synonyms.index(synonym) }
      end
    end
  end
end