class GenusTypesController < ApplicationController
  respond_to :html, :json

  def index
    @genus_types = GenusType.find(:all, :order => :name)
  end

  def show
    @genus_type = GenusType.find(params[:id])
  end

  def new
    @genus_type = GenusType.new()
  end

  def create
    @genus_type = GenusType.new(params[:genus_type])
    if @genus_type.save
      flash[:notice] = "Added a new Genus Type!"
      respond_with(@genus_type, :location => genus_types_url)
    else
      respond_with(@genus_type)
    end
  end

  def edit
    @genus_type = GenusType.find(params[:id])
  end

  def update
    @genus_type = GenusType.find(params[:id])
    if @genus_type.update_attributes(params[:genus_type])
      flash[:notice] = "Updated Genus Type!"
      respond_with(@genus_type, :location => genus_types_url)
    else
      respond_with(@genus_type)
    end
  end

  def destroy
    @genus_type = GenusType.find(params[:id])
    @genus_type.destroy
    flash[:notice] = "Destroyed Genus Type!"
    respond_with(@genus_type, :location => genus_types_url)
  end
end
