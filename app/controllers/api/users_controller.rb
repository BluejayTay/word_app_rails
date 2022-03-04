class Api::UsersController < ApplicationController
  #before_action :authenticate_request!, except: [:create, :login]
  
  def create
    user = User.new(user_params)
  
    if user.save && user.authenticate(params[:password])
      auth_token = JsonWebToken.encode(user_id: user.id)
      render json: { auth_token: auth_token }, status: :ok
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(user_params[:password])
      auth_token = JsonWebToken.encode(user_id: user.id)
      render json: { auth_token: auth_token }, status: :ok
    else
      render json: { error: 'Invalid username/password' }, status: :unauthorized
    end
  end
  
  private

  def user_params
    params.permit(:email, :password)
  end
end
