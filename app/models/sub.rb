class Sub < ActiveRecord::Base
  belongs_to(
    :mod,
    class_name: "User"
  )

  has_many(
    :post_subs
  )

  has_many(
    :posts,
    through: :post_subs,
    source: :post,
    inverse_of: :subs,
    dependent: :destroy
  )

  validates :title, presence: true, uniqueness: true
end
