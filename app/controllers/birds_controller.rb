class BirdsController < ApplicationController
  respond_to :html, :json

  def index
    if params[:query]
      @query = Query.new(params[:query])
    elsif current_user.query
      @query = current_user.query
    else
      @query = Query.new()
    end
    @birds = @query.results  
    respond_with(@birds)
  end


  def search
    @query = Query.new(params[:query])
    #@query.hide_fields = @schema.schema_fields.map{|f| f.key }.delete_if{|f| @query.view_fields.include?(f)}
    @birds = @query.results
    respond_with(@birds) do |format|
      format.html do
        if request.xhr?
          render :partial => "birds_list", :object => @birds
        else
          render "index"
        end
      end
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
