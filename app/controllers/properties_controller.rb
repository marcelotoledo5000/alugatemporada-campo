class PropertiesController < ApplicationController
  def search
    @properties = Property.where(property_location_id: params[:q])

    if @properties.empty?
      flash[:alert] = 'Nenhum resultado encontrado'
    end
  end

  def show
    @property = Property.find_by(id: params[:id])
    if @property.nil?
      flash[:alert] = 'Imóvel não encontrado'
      redirect_to properties_path
    end
  end

  def index
  end
end
