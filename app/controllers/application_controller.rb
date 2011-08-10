class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  before_filter :get_bird_schema
  
  helper :all
  protect_from_forgery

  protected

  def get_bird_schema
    @bird_schema = Schema.where(:name => "bird").first
  end

end
