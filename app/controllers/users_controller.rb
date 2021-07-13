class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'User successfully created'
    else
      render 'new', alert: 'Something went wrong'
    end
  end

  # private

  def user_params
    params.require(:user).permit(:name)
  end
end