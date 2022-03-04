class Api::StudyListsController < ApplicationController
  #to (hopefully) allow non-logged in users to play base study_lists
  before_action :load_current_user!, except: [:start_game, :show] 

  def index
    user = @current_user
    study_lists = (user.study_lists + StudyList.all.where(user_id: nil))
    render json: study_lists
  end
  
  def show
    study_list = StudyList.find(params[:id])
    render json: study_list
  end
  
  def create
    user = @current_user
    
    study_list = StudyList.create(study_list_params)
    study_list.user_id = user.id
    if study_list.save
      render json: study_list
    else
      render json: study_list.errors, status: :unprocessable_entity
    end
  end

  def update
    study_list = StudyList.find(params[:id])
    if study_list.update(study_list_params)
      render json: study_list
    else
      render json: study_list.errors, status: :unprocessable_entity
    end
  end

  def destroy
    study_list = StudyList.find(params[:id])
    study_list.destroy
  end

  private

  def study_list_params
    params.permit(:title, :high_score)
  end
end
