class PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
    @comments_by_parent_id = @post.comments_by_parent_id
    render :show
  end

  def new
    @post = current_user.authored_posts.new
    render :new
  end

  def create
    @post = current_user.authored_posts.new(post_params)

    if @post.save
      flash[:notice] = "Post saved!"
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = current_user.authored_posts.find(params[:id])
    render :edit
  end

  def update
    @post = current_user.authored_posts.find(params[:id])

    if @post.update(post_params)
      flash[:notice] = "Post updated!"
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end

end