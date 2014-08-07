class Sub < ActiveRecord::Base
  belongs_to(
    :mod,
    class_name: "User"
  )

  has_many(
    :posts,
    dependent: :destroy
  )

  validates :title, presence: true, uniqueness: true
end
