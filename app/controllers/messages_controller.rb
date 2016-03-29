class MessagesController < ApplicationController
  # Empty action, it's ok, rails will default to index view
  def index
  end
 
  # Fetching last 10 messages, how cool is that when people don't respect conventions -.-'
  def show
    data = {}
    data['messages'] = $firebase.get('messages', orderBy: '$key', limitToLast: 10)
    data['username'] = session[:username]
    
    render json: data
  end
end
