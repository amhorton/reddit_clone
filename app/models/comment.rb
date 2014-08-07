class Comment < ActiveRecord::Base
  validates :author, :post, presence: true
  
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
  
  
  
end
