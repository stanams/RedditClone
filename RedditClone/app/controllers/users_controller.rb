class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
    render :new
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  def create
    @user = User.find_by(user_name: user_params[:user_name])
    if @user.save
      redirect_to user_url(@user)
    else
      render :new 
    end
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :password)
  end

end