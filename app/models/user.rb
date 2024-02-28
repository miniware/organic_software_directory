class User < ApplicationRecord
  has_many :listings
  has_many :comments

  passwordless_with :email
  validates :email,
    presence: true,
    uniqueness: true,
    format: {with: URI::MailTo::EMAIL_REGEXP}

  validates :handle,
    presence: true,
    uniqueness: true,
    format: {with: /\A[\w\-]+\z/, message: "only allows letters, numbers, dashes, and underscores"}

  normalizes :handle, :email,
    with: ->(text) { text.strip.downcase }

  def to_param
    handle
  end
end
