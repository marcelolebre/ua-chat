Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homepage#index'
  get '/', to: 'homepage#index'
  post '/login', to: 'homepage#login'
  delete '/logout', to: 'homepage#logout'
  get '/chat', to: 'messages#index'
  get '/messages', to: 'messages#show'

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
end
