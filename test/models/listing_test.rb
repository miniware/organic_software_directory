require "test_helper"

class ListingTest < ActiveSupport::TestCase
  test "fills in details from OG meta tags if not provided" do
    VCR.use_cassette("audiopen_meta") do
      user = users(:one)
      # Assuming the title and icon are not set explicitly to trigger the HTTP request.
      listing = Listing.new(link: "https://audiopen.ai", user: user)
      listing.valid?
      assert_not_nil listing.title
      assert_not_nil listing.icon
    end
  end

  test "should not allow posting a link from the same base URL within a month" do
    user = users(:one)
    existing_listing = listings(:one)
    new_listing = Listing.new(title: "New Title", link: existing_listing.link, user: user)
    assert_not new_listing.valid?
  end
end
