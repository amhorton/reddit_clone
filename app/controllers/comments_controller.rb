class CommentsController < ApplicationController
  def new
    @comment = current_user.authored_comments.new
    @post_id = params[:post_id]
    render :new
  end

  def create

    if params.keys.include?(:post_id)
      create_top_level
    else
      create_nested
    end

  end


  def show
    @comment = Comment.find(params[:id])
    render :show
  end

  def edit

  end

  def update

  end

  def destroy
    @comment = current_user.authored_comments.find(params[:id])
    @comment.content = "[deleted]"

    redirect_to post_url(@comment.post)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_comment_id)
  end

  def create_top_level
    fail
    @comment = current_user.authored_comments.new(comment_params)

    if @comment.save
      flash[:notice] = "Comment saved!"
      redirect_to post_url(@comment.post)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  def create_nested
    @comment = current_user.authored_comments.new(comment_params)
    @comment.post = @comment.parent_comment.post

    if @comment.save
      flash[:notice] = "Comment saved!"
      redirect_to comment_url(@comment.parent_comment)
    else
      flash.now[:errors] = @comment.errors.full_messages

      @comment = @comment.parent_comment
      render :show
    end
  end
end
