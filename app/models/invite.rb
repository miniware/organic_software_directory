class Invite < ApplicationRecord
  belongs_to :sent_by, class_name: "User"
  belongs_to :accepted_by, class_name: "User", optional: true

  generates_token_for :invite_code do
    recipient_email
  end

  normalizes :recipient_email, with: ->(email) { email.strip.downcase }
  validates :recipient_email,
    presence: true,
    uniqueness: {message: "already invited"},
    format: {with: URI::MailTo::EMAIL_REGEXP}

  validate :recipient_is_not_user, on: :create
  validate :sender_has_remaining_invites, on: :create

  def accepted?
    accepted_by.present?
  end

  def code
    generate_token_for(:invite_code)
  end

  private

  def recipient_is_not_user
    if User.exists?(email: recipient_email)
      errors.add(:recipient_email, "is already an existing user")
    end
  end

  def sender_has_remaining_invites
    unless sent_by.invites.remaining > 0
      errors.add(:sent_by, "doesn't have remaining invites")
    end
  end
end
