class SubsController < ApplicationController

  def index
    @subs = Sub.all
  end

  def new
    @sub = Sub.new()
    render :new
  end

  def show
    @sub = Sub.find(params[:id])
    # fail
    render :show
  end

  def create
    if logged_in?
      @sub = current_user.subs.new(sub_params)
      if @sub.save
        redirect_to subs_url
      else
        render :new
      end
    else
      redirect_to new_session_url
    end
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    if logged_in?

      @sub = Sub.find(params[:id])
      if @sub.update(sub_params)
        redirect_to subs_url
      else
        render :new
      end
    else
      redirect_to new_session_url
    end
  end

  private

  def sub_params
    params.require(:subs).permit(:title, :description)
  end
end
