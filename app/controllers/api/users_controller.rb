class Api::UsersController < ApplicationController
  before_action :authenticate_request!, only: [:auto_login, :show]
  
  def create # POST api/users
    user = User.new(user_params)
  
    if user.save && user.authenticate(user_params[:password])
      auth_token = JsonWebToken.encode(user_id: user.id)
      render json: { user: { id: user.id, email: user.email}, auth_token: auth_token }, status: :ok
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def login # POST api/users/login
    user = User.find_by(email: user_params[:email])

    if user&.authenticate(user_params[:password])
      auth_token = JsonWebToken.encode(user_id: user.id)
      render json: { user: { id: user.id, email: user.email}, auth_token: auth_token }, status: :ok
    else
      render json: { error: 'Invalid username/password' }, status: :unauthorized
    end
  end

  def auto_login # GET api/users/auto_login
    if payload
      render json: {user: { id: @current_user.id, email: @current_user.email} }
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
