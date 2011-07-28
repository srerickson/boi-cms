class OrgStylesController < ApplicationController
  respond_to :html, :json

  def index
    @org_styles = OrgStyle.find(:all, :order => :name)
  end

  def show
    @org_style = OrgStyle.find(params[:id])
  end

  def new
    @org_style = OrgStyle.new()
  end

  def create
    @org_style = OrgStyle.new(params[:org_style])
    if @org_style.save
      flash[:notice] = "Added a new OrgStyle!"
      respond_with(@org_style, :location => org_styles_url)
    else
      respond_with(@org_style)
    end
  end

  def edit
    @org_style = OrgStyle.find(params[:id])
  end

  def update
    @org_style = OrgStyle.find(params[:id])
    if @org_style.update_attributes(params[:org_style])
      flash[:notice] = "Updated OrgStyle!"
      respond_with(@org_style, :location => org_styles_url)
    else
      respond_with(@org_style)
    end
  end

  def destroy
    @org_style = OrgStyle.find(params[:id])
    @org_style.destroy
    flash[:notice] = "Destroyed OrgStyle!"
    respond_with(@org_style, :location => org_styles_url)
  end

end
