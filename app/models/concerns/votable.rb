module Votable
  extend ActiveSupport::Concern

  included do
    has_many(
      :votes,
      as: :votable,
      dependent: :destroy
    )
  end

  def score
    votes.map(&:value).inject(:+)
  end

end