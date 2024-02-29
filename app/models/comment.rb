class Comment < ApplicationRecord
  include Votable

  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable

  validates :body, presence: true
  normalizes :body, with: ->(body) { body.strip }
end
