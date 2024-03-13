class Comment < ApplicationRecord
  include Votable
  include TotalComments

  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
  has_many :notification_mentions, as: :record, dependent: :destroy, class_name: "Noticed::Event"

  validates :body, presence: true
  normalizes :body, with: ->(body) { body.strip }

  def to_s
    body.truncate(40)
  end
end
