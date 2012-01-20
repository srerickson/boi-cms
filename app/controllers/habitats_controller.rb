class HabitatsController < ApplicationController
  respond_to :html, :json

  def index
    @habitats = Habitat.find(:all, :order => :name)
    respond_with do |f|
      f.html { render :index }
      f.json { render :json => @habitats }
    end

  end

  def show
    @habitat = Habitat.find(params[:id])
  end

  def new
    @habitat = Habitat.new()
  end

  def create
    @habitat = Habitat.new(params[:habitat])
    if @habitat.save
      flash[:notice] = "Added a new Habitat!"
      respond_with(@habitat, :location => habitats_url)
    else
      respond_with(@habitat)
    end
  end

  def edit
    @habitat = Habitat.find(params[:id])
  end

  def update
    @habitat = Habitat.find(params[:id])
    if @habitat.update_attributes(params[:habitat])
      flash[:notice] = "Updated Habitat!"
      respond_with(@habitat, :location => habitats_url)
    else
      respond_with(@habitat)
    end
  end

  def destroy
    @habitat = Habitat.find(params[:id])
    @habitat.destroy
    flash[:notice] = "Destroyed Habitat!"
    respond_with(@habitat, :location => habitats_url)
  end

end
