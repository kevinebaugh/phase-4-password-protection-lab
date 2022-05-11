class UsersController < ApplicationController
  def create
    if params[:password] != params[:password_confirmation]
      return render json: {error: "Check yer password"}, status: :unprocessable_entity
    end

    user = User.create(username: params[:username], password: params[:password])
    session[:user_id] = user.id
    render json: user
  end

  def show
    if session[:user_id]
      user = User.find_by(id: session[:user_id])
      render json: user
    else
      render json: {error: "nope"}, status: :unauthorized
    end
  end
end
