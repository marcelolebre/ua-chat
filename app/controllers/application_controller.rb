class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate
  
  # Check if user has valid session username
  def authenticate
    redirect_to(root_path) unless session[:username]
  end
  
  # Retrieves current username from session
  def current_user
    session[:username]
  end
end
