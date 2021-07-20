class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if User.exists?(name: user_params[:name])
      session[:user_id] = User.find_by(name: user_params[:name]).id
      redirect_to root_path
    else
      render 'sessions/new', alert: 'User doesn\'t exist'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
