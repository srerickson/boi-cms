class SchemasController < ApplicationController
  respond_to :html, :json

  def index
    @schemas = Schema.find(:all, :order => :name)
  end

  def show
    @schema = Schema.find(params[:id])
  end

  def new
    @schema = Schema.new()
  end

  def create
    @schema = Schema.new(params[:schema])
    if @schema.save
      flash[:notice] = "Added a new Schema!"
      respond_with(@schema, :location => schemas_url)
    else
      respond_with(@schema)
    end
  end

  def edit
    @schema = Schema.find(params[:id])
  end

  def update
    @schema = Schema.find(params[:id])
    if @schema.update_attributes(params[:schema])
      flash[:notice] = "Updated Schema!"
      respond_with(@schema)
    else
      respond_with(@schema)
    end
  end

  def destroy
    @schema = Schema.find(params[:id])
    @schema.destroy
    flash[:notice] = "Destroyed Schema!"
    respond_with(@schema, :location => schemas_url)
  end

end
