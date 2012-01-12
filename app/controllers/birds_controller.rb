class BirdsController < ApplicationController
  respond_to :html, :json

  def index
    self.get_query 
    @birds = @query.results  
    respond_with(@birds)
  end


  def search
    self.get_query
    @birds = @query.results
    #current_user.set_query(@query)
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

  def flexi
    ret = {}
    ret[:total] = 1
    ret[:rows] = []
    ret[:rows] << {:id=>1, :cell => {:name => "Seth", :image => "<img src='/images/dodo-small.png'/>"}}
    respond_with(ret)
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
      respond_with do |f|
        f.html do
          if request.xhr?
            render :partial => "form", :layout => false;
          else
            respond_with(@bird)
          end
        end
      end
    end
  end


  def edit
    @bird = Bird.find(params[:id])
  end


  def update
    @bird = Bird.find(params[:id])
    if @bird.update_attributes(params[:bird])
      respond_with do |f|
        f.html do 
          if request.xhr?
            render :partial => "form", :layout => false;
          else
            flash[:notice] = "Updated Bird!"
            respond_with(@bird, :location => birds_url)
          end
        end
      end
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

protected

  def get_query
    @query = nil;
    if params[:query]
      @query = Query.new(params[:query])
    #elsif current_user.query
    #  @query = current_user.query
    else
      @query = Query.new()
    end
  end

end
