class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update]

  def show
  end

  def index
    @listings = Listing.all
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.user ||= User.first # TODO: TEMPORARY

    # @listing.fill_in_details_from_og_meta_tags

    if @listing.save
      redirect_to @listing, notice: "Listing was successfully created."
    else
      puts @listing.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @listing.update(listing_params)
      redirect_to @listing, notice: "Listing was successfully updated."
    else
      puts @listing.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_listing
    @listing = Listing.find(params[:id])
  end

  def listing_params
    params.require(:listing).permit(:title, :description, :link, :user_id)
  end
end
