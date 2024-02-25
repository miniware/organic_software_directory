class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update]

  def show
  end

  def index
    @new_listing = Listing.new
    @listings = Listing.all
  end

  def edit
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.user ||= User.first # TODO: TEMPORARY

    if @listing.save
      redirect_to edit_listing_path(@listing), notice: "Listing was successfully created."
    else
      puts @listing.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
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
    params.require(:listing)
      .permit(
        :title,
        :description,
        :link,
        :user_id,
        :icon,
        :cover
      )
  end
end
