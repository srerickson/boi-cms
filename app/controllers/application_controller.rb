class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  
  helper :all
  protect_from_forgery

  protected

  def get_schema
    @schema = Schema.find_by_name("bird")
  end

end
