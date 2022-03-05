class Api::StudyListsController < ApplicationController
  before_action :authenticate_request!, except: [:game, :index]
  before_action :load_current_user!
  def game # POST api/study_lists/:id/game
    study_list = StudyList.find(params[:id])
    
  end
  
  def index # GET api/study_lists
    @current_user.nil? ? study_lists = base_study_lists : study_lists = (@current_user.study_lists + base_study_lists)
    
    render json: study_lists
  end
  
  def show # GET api/study_lists/:id
    study_list = StudyList.find(params[:id])
    render json: study_list
  end
  
  def create # POST api/study_lists/:id
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
    study_list = StudyList.find(params[:id])
    if study_list.update(study_list_params)
      render json: study_list
    else
      render json: study_list.errors, status: :unprocessable_entity
    end
  end

  def destroy #DELETE api/study_lists/:id
    study_list = StudyList.find(params[:id])
    study_list.destroy
  end

  private

  def base_study_lists
    StudyList.all.where(user_id: nil)
  end

  def study_list_params
    params.permit(:title, :high_score)
  end
end
