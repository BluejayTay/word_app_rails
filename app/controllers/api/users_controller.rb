class Api::UsersController < ApplicationController
  #before_action :authenticate_request!, except: [:create, :login] # Exclude this route from authentication
  #just for testing things out atm
  def index
    users = User.all
    render json: users
  end

  def create
    @user = User.new(user_params)
  
    if @user.save && @user.authenticate(user_params[:password])
      auth_token = JsonWebToken.encode(user_id: @user.id)
      render json: { auth_token: auth_token }, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: user_params[:email].to_s.downcase)

    if user&.authenticate(user_params[:password])
      auth_token = JsonWebToken.encode(user_id: user.id)
      render json: { auth_token: auth_token }, status: :ok
    else
      render json: { error: 'Invalid username/password' }, status: :unauthorized
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
