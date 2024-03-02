class Listing < ApplicationRecord
  include Votable
  include TotalComments

  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  before_save :generate_slug
  before_validation :fill_in_details_from_og_meta_tags

  validate :not_posted_recently, on: :create

  validates :link, presence: true,
    format: {with: URI::DEFAULT_PARSER.make_regexp, message: "must be a valid URL"}

  validates :icon, :cover,
    format: {with: URI::DEFAULT_PARSER.make_regexp, message: "must be a valid URL", allow_blank: true}

  validates :title, presence: true, uniqueness: {case_sensitive: false}

  def to_param
    slug
  end

  private

  def generate_slug
    self.slug = title.parameterize if title_changed? || slug.blank?
  end

  def fill_in_details_from_og_meta_tags
    page = MetaInspector.new(link)
    self.title ||= page.best_title
    self.description ||= page.best_description
    self.icon = find_apple_touch_icon(page) || page.images.favicon if icon.blank?
    self.cover = page.images.best if cover.blank?
  rescue => e
    Rails.logger.error "MetaInspector failed for #{link}: #{e.message}"
  end

  def find_apple_touch_icon(page)
    link_element = page.parsed.css('link[rel="apple-touch-icon"]').first
    if link_element
      href = link_element["href"]
      # Check if the href is a full URL
      if URI.parse(href).host.nil?
        # If not, join it with the page's base URL
        href = URI.join(page.url, href).to_s
      end
      href
    end
  rescue => e
    Rails.logger.error "Failed to find apple-touch-icon for #{page.url}: #{e.message}"
    nil
  end

  def not_posted_recently
    base_url = URI.parse(link).host
    if Listing.where("created_at >= ?", 1.month.ago).where("link LIKE ?", "%#{base_url}%").exists?
      errors.add(:base, "This link was posted too recently.")
    end
  end
end
