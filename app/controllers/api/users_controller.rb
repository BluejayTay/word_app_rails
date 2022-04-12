# frozen_string_literal: true

module Api
  class UsersController < ApplicationController
    before_action :authenticate_request!, only: %i[auto_login show]
    before_action :validate_params, only: :create

    # POST api/users
    def create
      user = User.new(user_params)

      if user.save && user.authenticate(password)
        auth_token = JsonWebToken.encode(user_id: user.id)
        render json: { user: { id: user.id, email: user.email }, auth_token: auth_token }, status: :ok
      else
        render json: user.errors, status: :unprocessable_entity
      end
    end

    # POST api/users/login
    def login
      user = User.find_by(email: email)

      if user&.authenticate(password)
        auth_token = JsonWebToken.encode(user_id: user.id)
        render json: { user: { id: user.id, email: user.email }, auth_token: auth_token }, status: :ok
      else
        render json: { error: 'Invalid username/password' }, status: :unauthorized
      end
    end

    # GET api/users/auto_login
    def auto_login
      render json: { user: { id: @current_user.id, email: @current_user.email } } if payload
    end

    private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

    def email
      user_params[:email]
    end

    def password
      user_params[:password]
    end

    def validate_params
      raise if email.empty? || password.empty?
    end
  end
end
