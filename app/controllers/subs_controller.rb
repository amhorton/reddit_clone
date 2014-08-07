class SubsController < ApplicationController
  before_action :require_signed_in, except: [:index, :show]

  def index
    @subs = Sub.all
    render :index
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = current_user.owned_subs.new(sub_params)

    if @sub.save
      flash[:notice] = "Successfully created /rc/#{@sub.title}."
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = current_user.owned_subs.find(params[:id])
  end

  def update
    @sub = current_user.owned_subs.find(params[:id])

    if @sub.update(sub_params)
      flash[:notice] = "Successfully updated /rc/#{@sub.title}."
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def destroy
    @sub = current_user.owned_subs.find(params[:id])
    @sub.destroy
    redirect_to posts_url
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end