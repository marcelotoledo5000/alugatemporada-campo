class PropertiesController < ApplicationController
  before_action :authenticate_property_owner!, only: [:new, :create]

  def search
    @properties = Property.where(property_location_id: params[:q])

    if @properties.empty?
      flash[:alert] = 'Nenhum resultado encontrado'
    end
  end

  def show
    @property = Property.find_by(id: params[:id])
    if @property.nil?
      redirect_to root_path
    else
      @proposals = @property.proposals.where.not(status: :rejected)
    end
  end

  def new
    @property = Property.new
    @locations = PropertyLocation.all
  end

  def create
    property_params = params.require(:property).permit(:title,:maximum_guests,
                        :maximum_rent, :minimum_rent, :daily_rate, :rent_purpose,
                        :property_location_id, :description, :neighborhood,
                        :accessibility, :allow_pets, :allow_smokers, :rooms,
                        :main_photo, :property_owner_id
                      )

    @property = Property.new(property_params)
    @property.property_owner = current_property_owner

    if @property.save
      redirect_to @property
    else
      @locations = PropertyLocation.all
      render :new
    end
  end

  def index
    @properties = current_property_owner.properties

    if @properties.empty?
      flash[:alert] = 'Você não possui propriedades cadastrada'
    end
  end
end
