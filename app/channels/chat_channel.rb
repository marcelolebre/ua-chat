class ChatChannel < ApplicationCable::Channel

  # Client subscribes channel
  def subscribed
    stream_from params[:room]
  end
  
  # Receive message from client
  def message(data)
    ActionCable.server.broadcast(params[:room], data)
    $firebase.post('/messages', data)
  end
end
