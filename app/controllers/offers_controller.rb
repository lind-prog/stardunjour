class OffersController < ApplicationController
  before_action :set_offer, only: %i[show]
  def index
    @offers = Offer.all
  end

  def new
    @offer = Offer.new
  end

  def create
    @offer = Offer.new(offer_params)
    @offer.user = current_user
    if @offer.save
      redirect_to offers_path, notice: "Great ! Your offer was created !"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end
  #afficher la nouvelle offre dans la view de l'index
  #retourner sur l'offre une fois le create terminé
  #inserer une image avec le tout

  private

  def offer_params
    params.require(:offer).permit(:title, :price, :image, :number_of_fan, :activity, :enthusiasm_level)
  end

  def set_offer
    @offer = Offer.find(params[:id])
  end
end
