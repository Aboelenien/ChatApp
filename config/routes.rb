Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :applications, only: %i[index create] do
        collection do
          get '/:token', to: 'applications#show'
          put '/:token', to: 'applications#update'
          get '/:token/chats', to: 'application_chats#index'
          get '/:token/chats/:number', to: 'application_chats#show'
          post '/:token/chats', to: 'application_chats#create'
          get '/:token/chats/:number/messages', to: 'chat_messages#index'
          post '/:token/chats/:number/messages', to: 'chat_messages#create'
          get '/:token/chats/:number/messages/:message_number', to: 'chat_messages#show'
          put '/:token/chats/:number/messages/:message_number', to: 'chat_messages#update'
        end
      end
    end
  end
end
