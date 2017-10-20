class UsersController < ApplicationController
  before_action :authenticate_user, except: [:show, :create]

  def show
    render json: User.find_by(username: params[:id])
  end

  def create
    User.create(username: auth_params[:username], password: auth_params[:password], password_confirmation: auth_params[:password])
  end

  def current
    render json: current_user
  end

  def refresh_token
    token = Knock::AuthToken.new(payload: current_user.to_token_payload ).token
    render json: { jwt: token }
  end

  def auth_params
    params.require(:auth).permit(:username, :password)
  end
end
