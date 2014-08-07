class Comment < ActiveRecord::Base
  include Votable

  validates :author, :post_id, presence: true

  belongs_to(
    :author,
    class_name: "User"
  )

  belongs_to(
    :post
  )

  belongs_to(
    :parent_comment,
    class_name: "Comment"
  )

  has_many(
    :child_comments,
    class_name: "Comment",
    foreign_key: :parent_comment_id
  )

  def children_by_parent_id
    hash = Hash.new { |h, k| h[k] = []}

    self.child_comments.includes(:votes).each do |comment|
      hash[comment.parent_comment_id] << comment
    end

    hash
  end
end
