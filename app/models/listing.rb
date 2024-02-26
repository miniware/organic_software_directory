class Listing < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  before_validation :fill_in_details_from_og_meta_tags
  validate :not_posted_recently, on: :create

  validates :link, presence: true,
    format: {with: URI::DEFAULT_PARSER.make_regexp, message: "must be a valid URL"}

  validates :icon, :cover,
    format: {with: URI::DEFAULT_PARSER.make_regexp, message: "must be a valid URL", allow_nil: true}

  validates :title, presence: true

  private

  def fill_in_details_from_og_meta_tags
    page = MetaInspector.new(link)
    self.title ||= page.best_title
    self.description ||= page.best_description
    self.icon ||= find_apple_touch_icon(page) || page.images.favicon
    self.cover ||= page.images.best
  rescue => e
    Rails.logger.error "MetaInspector failed for #{link}: #{e.message}"
  end

  def find_apple_touch_icon(page)
    page.images.all.find { |l| l.include?('rel="apple-touch-icon"') }
  end

  def not_posted_recently
    base_url = URI.parse(link).host
    if Listing.where("created_at >= ?", 1.month.ago).where("link LIKE ?", "%#{base_url}%").exists?
      errors.add(:base, "This link was posted too recently.")
    end
  end
end
