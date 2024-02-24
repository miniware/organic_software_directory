class User < ApplicationRecord
  has_many :listings

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
end
