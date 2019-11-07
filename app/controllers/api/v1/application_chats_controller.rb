class Api::V1::ApplicationChatsController < Api::V1::ApiController
  before_action :set_application

  def index
    @chats = @application.chats.all
    render json: @chats
  end


  def show
    @chat = @application.chats.find_by(number: params[:number])
    render json: @chat
  end

  def create
    retries ||= 3
    @chat = @application.chats.build
    @chat.number = @application.chats.count + 1
    @application.chats_count = @chat.number
    if @chat.save
      if @application.save
        render json: @chat, status: :created
      end
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotUnique
    retry unless (retries-=1).zero?
    raise
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application
      @application = Application.find_by(token: params[:token])
    end
end
