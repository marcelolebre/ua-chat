App.controller 'MessagesCtrl', ['$scope', '$http', ($scope, $http) ->
  $scope.messages = []

  # Initiate websocket connection and setup our callbacks
  App.chatChannel = App.cable.subscriptions.create { channel: "ChatChannel", room: "UAChat" },
    # Append received messages to our html element
    received: (data) ->
      $scope.messages.push(data)
    
    # Send new message to the backend
    sendMessage: (data) ->
      @perform 'message', data
  
  # Fetch pre-existing list of messages
  $http(
    method: 'GET'
    url: '/messages').then (response) ->
      # set scope username
      $scope.username = response.data.username

      # set scope message list
      angular.forEach response.data.messages, (message) ->
        $scope.messages.push(message) 

  # When user presses send button send object
  $scope.sendMessage = ->
    App.chatChannel.sendMessage { username: $scope.username, message: $scope.message }
    $scope.message = ""
]