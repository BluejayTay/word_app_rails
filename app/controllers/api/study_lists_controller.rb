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
        synonyms.each_with_index do |_synonym, _index|
          @game_synonym = synonyms[(rand(synonym_count))]
        end
        @game_synonyms << @game_synonym
      end

      render json: {
        study_list: StudyListSerializer.new(@study_list),
        words: words_and_match_indices,
        synonyms: game_synonyms_and_match_indices
      }
    end

    def index
      if payload
        load_current_user!
        @study_lists = base_study_lists + user_study_lists
      else
        @study_lists = base_study_lists
      end

      render json: @study_lists
    end

    def create
      @study_list = StudyList.create(study_list_params)

      submitted_words = params[:words]
      submitted_words.each do |word|
        name = word.downcase.delete(' ')
        if databased_word = Word.find_by(name: name)
          words << databased_word
        else
          result = ThesaurusService.look_up(name)
          next if result == 'Error: Word not found'
          
          new_word = Word.create!(name: name, definition: result['shortdef'].join('; '))
          words << new_word

          synonyms_result = result['meta']['syns'].flatten
          synonyms_result.each do |synonym|
            new_word.synonyms << Synonym.find_or_create_by!(name: synonym)
          end
        end
      end

      if @study_list.invalid_word_count?
        destroy_list_and_raise_error
      else
        render json: { study_list: { title: @study_list.title, words: words } }
      end
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

    def destroy_invalid_list
      StudyList.transaction do
        @study_list.destroy
      end
    end

    def destroy_list_and_raise_error
      destroy_invalid_list

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