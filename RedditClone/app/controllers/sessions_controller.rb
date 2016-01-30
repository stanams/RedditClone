class SessionsController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:user_name],
                                    params[:user][:password])
    if @user.nil?
      @user = User.new
      render :new
    else
      log_in!(@user)
      redirect_to user_url(@user)
    end
  end

  def destroy
    log_out!
    redirect_to new_session_url
  end

  private
  def session_params
    params.require(:user).permit(:user_name, :password, :session_token)
  end


end
