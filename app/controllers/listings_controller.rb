class ListingsController < ApplicationController
  before_action :require_user!, except: [:index, :show]

  def show
    @listing = Listing.includes(comments: [:comments]).find(params[:id])
  end

  def index
    @new_listing = Listing.new
    @listings = Listing.all
  end

  def create
    @listing = current_user.listings.new(listing_params)

    if @listing.save
      redirect_to edit_listing_path(@listing), notice: "Listing was successfully created."
    else
      puts @listing.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end

  def edit
    @listing = Listing.find(params[:id])
  end

  def update
    @listing = Listing.find(params[:id])
    if @listing.update(listing_params)
      redirect_to @listing, notice: "Listing was successfully updated."
    else
      puts @listing.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def listing_params
    params.require(:listing)
      .permit(
        :title,
        :description,
        :link,
        :icon,
        :cover
      )
  end
end
