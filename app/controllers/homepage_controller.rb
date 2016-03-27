class HomepageController < ApplicationController
  skip_before_action :authenticate
  
  # Redirect to chat view if user has valid session
  def index
    redirect_to(chat_path) if current_user
  end

  # Register username in session and redirect user to chat view
  def login
    session[:username] = login_params[:username].to_s
    redirect_to(chat_path)
  end
 
  # Clean user session and redirect to homepage
  def logout
    reset_session
    redirect_to(root_path)
  end
  
  private

  # Only allow username in the request parameters
  def login_params
    params.permit(:username)
  end
end
