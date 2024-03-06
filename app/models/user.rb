class User < ApplicationRecord
  has_many :listings
  has_many :comments
  has_many :votes

  enum role: %w[member admin].index_by(&:itself)

  has_one :accepted_invite, class_name: "Invite", foreign_key: "accepted_by_id"
  has_many :invites, foreign_key: "sent_by_id" do
    def remaining
      if proxy_association.owner.admin?
        Float::INFINITY # unlimited
      else
        [3 - proxy_association.owner.invites.count, 0].max
      end
    end

    def remaining?
      remaining > 0
    end
  end

  def gain_karma!
    change_karma_by(1)
  end

  def damage_karma!
    change_karma_by(-1)
  end

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

  private

  def change_karma_by amount
    increment!(:karma, amount) if amount > 0
    decrement!(:karma, amount.abs) if amount < 0
  end
end
