class VotesController < ApplicationController

  def comment_upvote
    Vote.create(
      votable_type: "Comment",
      votable_id: params[:comment_id],
      value: 1
    )
    redirect_to(:back)
  end

  def comment_downvote
    Vote.create(
      votable_type: "Comment",
      votable_id: params[:comment_id],
      value: -1
    )
    redirect_to(:back)
  end

  def post_upvote
    Vote.create(
      votable_type: "Post",
      votable_id: params[:post_id],
      value: 1
    )
    redirect_to(:back)
  end

  def post_downvote
    Vote.create(
      votable_type: "Post",
      votable_id: params[:post_id],
      value: -1
    )
    redirect_to(:back)
  end

end