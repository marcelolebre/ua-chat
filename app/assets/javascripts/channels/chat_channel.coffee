# Initiating jQuery context
$ ->
  # Defining a function that given an argument will create a p element with username and message
  message_html = (data) ->
    "<p>" + data['username'] + ": " + data['message'] + "</p>"
  
  # Declare callbacks for action cable messages
  App.chatChannel = App.cable.subscriptions.create { channel: "ChatChannel", room: "UAChat" },

    # Append received messages to our html element
    received: (data) ->
      $("#messages").append(message_html(data))
    
    # Send new message to the backend
    sendMessage: (data) ->
      @perform 'message', data
  
  # Build message with username and message body and send it to our backend on button click
  $("#message-button").click ->
    message = $('#message-input').val()
    $('#message-input').val('')
    username = $('#username').text()
    App.chatChannel.sendMessage({ username: username, message: message })
  
  # Fetch last 10 messages when we arrive to the channel
  $.get '/messages', (data) ->
    $.each data, (index, object) ->
      $("#messages").append(message_html(object))

  # Trigger button click when the user hits enter
  $('#message-input').keydown (event) ->
    if event.keyCode == 13
      $('#message-button').click()
