class PostsController < ApplicationController

  def show

  end

  def new

  end

  def create

  end

  def edit

  end

  def update

  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end

end