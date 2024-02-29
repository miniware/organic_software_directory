module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable, dependent: :destroy
    scope :popular, -> { left_joins(:votes).group(:id).order("COUNT(votes.id) DESC") }
  end
end
