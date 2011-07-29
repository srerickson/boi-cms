class BirdsController < ApplicationController
  respond_to :html, :json

  def index

    @birds = nil
    @query = Query.new()
    @query.setup_dicts()

    unless params[:selection].nil?
      ids = params[:selection].split(",").map{|s| s.to_i }
      @birds = Bird.where(:id => ids)
    end
   
    unless params[:search].nil? 
      unless params[:search][:order_by].nil?
        if Bird.column_names.include?(params[:search][:order_by])
          if @birds.nil?
            @birds = Bird.order(params[:search][:order_by]) 
          else
            @birds = @birds.order(params[:search][:order_by])
          end
        end
      end
    end

    if @birds.nil?
      @birds = Bird.order(:name)
    end
    respond_with(@birds)

  end

  def search
    @query = Query.new(params[:query])
    @query.setup_dicts()
    @birds = @query.results
    respond_with(@birds) do |format|
      format.html { render "index" }
    end
  end

  def show
    @bird = Bird.find(params[:id])
    respond_with(@bird)
  end

  def new
    @bird = Bird.new()
  end

  def create
    @bird = Bird.new(params[:bird])
    if @bird.save
      flash[:notice] = "Added a new Bird!"
      respond_with(@bird, :location => birds_url)
    else  
      respond_with(@bird)
    end
  end

  def edit
    @bird = Bird.find(params[:id])
  end

  def update
    @bird = Bird.find(params[:id])
    if @bird.update_attributes(params[:bird])
      flash[:notice] = "Updated Bird!"
      respond_with(@bird, :location => birds_url)
    else
      respond_with(@bird)
    end
  end

  def destroy
    @bird = Bird.find(params[:id])
    @bird.destroy
    flash[:notice] = "Destroyed Bird!"
    respond_with(@bird, :location => birds_url)
  end


end
