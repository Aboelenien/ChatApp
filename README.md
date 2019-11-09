# README

A chating system that allows the client to create new applications on it where the system generates its token.
Within Every application the client can create multiple chat and with every chat messages can be created.
The client should never see the ID of any of the entities. The client identifies the application by its token and the chat by
its number along with the application token and the message by the its message_number and chat number along with application's token. This application is dockerized and search here is done using elasticsearch.



Run this command to start the app
* docker-compose --project-name=ChatApp_development -f docker-compose.yml up --build

Run sudo sysctl -w vm.max_map_count=262144 if this appears
* [ max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144] ]

To Test the controllers
* Run docker-compose --project-name=ChatApp_development exec app  rspec spec/controllers

  To Test the models
* Run docker-compose --project-name=ChatApp_development exec app  rspec spec/models




API calls:

Getting all applications:
  * GET  /api/v1/applications(.:format)   

Creating new application:                                            
  * POST /api/v1/applications(.:format)
  sample input in request's body -->  { application: { name: "application"} }  
  the backend generates a token for the app once created


Getting application with token:                                         
  * GET  /api/v1/applications/:token(.:format)

Updating application  with this token:  
  * PUT  /api/v1/applications/:token(.:format)
  sample input in request's body -->  { application: { name: "application1"} }

Getting all chats for a certian application :                                       
  * GET  /api/v1/applications/:token/chats(.:format)

Getting chat with its number and application's token :                                
    * GET  /api/v1/applications/:token/chats/:number(.:format)

Creating new Chat in an application:                         
    * POST /api/v1/applications/:token/chats(.:format)
    --No data needed as an input, the chat is created in this application and a chat number will be assign by the system
      along with it. So here the chat is identified by the application token and its chat number    

Getting all messages or searched messages using elasticsearch in an chat of application:
    * GET  /api/v1/applications/:token/chats/:number/messages(.:format)
    -- if ypu want to search for words in the messages of this chat
       add {query: 'hello'} to the request


Creating new message in a chat of application:                 
    * POST /api/v1/applications/:token/chats/:number/messages(.:format)        
    Sample input in request's body -->  { message: { message: "hello world"} }
    --The message is created with the chat its :number is send and a message number will be assign by the system to it.


Getting message of a chat from application:   
    * GET  /api/v1/applications/:token/chats/:number/messages/:message_number(.:format)

Updating a message of a chat from application:
    * PUT  /api/v1/applications/:token/chats/:number/messages/:message_number(.:format)
    Sample input in request's body -->  { message: { message: "hello world1"} }
