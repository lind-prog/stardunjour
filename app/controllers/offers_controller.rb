class OffersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]
  before_action :set_offer, only: %i[show]

  def index
    if params[:query].present?
      @offers = Offer.global_search(params[:query])
    else
      @offers = Offer.all
    end
  end

  def new
    @offer = Offer.new
  end

  def create
    @offer = Offer.new(offer_params)
    @offer.user = current_user
    if @offer.save
      redirect_to offers_path, notice: "Great! Your offer was created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @booking = Booking.new
  end

  private

  def offer_params
    params.require(:offer).permit(:title, :price, :image, :number_of_fan, :activity, :localisation, :description, :enthusiasm_level)
  end

  def set_offer
    @offer = Offer.find(params[:id])
  end
end
