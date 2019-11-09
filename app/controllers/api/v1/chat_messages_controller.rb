class Api::V1::ChatMessagesController < Api::V1::ApiController
  before_action :set_chat

  def index
    @messages = @chat.messages.all
    if params[:query].present?
      @messages = @chat.messages.search(params[:query])
      @messages = @messages.map {|message| { number: message.number, message: message.message} if message.chat_id == @chat.id }.compact
      @messages = @messages.to_json
    end

    render json: @messages
  end


  def show
    @message = @chat.messages.find_by(number: params[:message_number])
    if @message
      render json: @message
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  def create
    retries ||= 3
    @message = @chat.messages.build(message_params)
    @message.number = @chat.messages.count + 1
    if @message.save
      render json: @message, status: :created
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotUnique
    retry unless (retries-=1).zero?
    raise
  end

  def update
    @message = @chat.messages.find_by(number: params[:message_number])
    if @message.update(message_params)
      render json: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @application = Application.find_by(token: params[:token])
      if @application.nil?
        raise ActiveRecord::RecordNotFound
      end
      @chat = Chat.find_by(application: @application, number: params[:number])
      if @chat.nil?
        raise ActiveRecord::RecordNotFound
      end
    end

    def message_params
      params.require(:message).permit(:message)
    end
end
