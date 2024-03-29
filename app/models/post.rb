class Post < ActiveRecord::Base
  include Votable

  belongs_to(
    :sub
  )

  belongs_to(
    :author,
    class_name: "User"
  )

  has_many(
    :post_subs,
    dependent: :destroy
  )

  has_many(
    :subs,
    through: :post_subs,
    source: :sub,
    inverse_of: :posts
  )

  has_many(
    :comments,
    dependent: :destroy
  )

  has_many(
    :top_level_comments,
    -> { where(parent_comment_id: nil) },
    class_name: "Comment"
  )

  validates :title, :author_id, presence: true
  # needs custom validation so you can't do both content and URL

  def comments_by_parent_id
    hash = Hash.new { |h, k| h[k] = []}

    self.comments.includes(:votes).each do |comment|
      hash[comment.parent_comment_id] << comment
    end

    hash
  end
end
