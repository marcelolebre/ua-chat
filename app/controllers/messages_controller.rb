class MessagesController < ApplicationController
  # Empty action, it's ok, rails will default to index view
  def index
  end
 
  # Fetching last 10 messages, how cool is that when people don't respect conventions -.-'
  def show
    messages = $firebase.get('messages', orderBy: '$key', limitToLast: 10)
    render json: messages
  end
end
