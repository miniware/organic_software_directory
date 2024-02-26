class Listings::CommentsController < CommentsController
  before_action :set_commentable

  private

  def set_commentable
    @commentable = Listing.find(params[:listing_id])
  end
end
