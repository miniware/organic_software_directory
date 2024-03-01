class Invite < ApplicationRecord
  belongs_to :sent_by, class_name: "User"
  belongs_to :accepted_by, class_name: "User", optional: true

  normalizes :recipient_email, with: ->(email) { email.strip.downcase }
  validates :recipient_email,
    presence: true,
    uniqueness: true,
    format: {with: URI::MailTo::EMAIL_REGEXP}

  validate :recipient_is_not_user

  private

  def recipient_is_not_user
    if User.exists?(email: recipient_email)
      errors.add(:recipient_email, "is already an existing user")
    end
  end
end
