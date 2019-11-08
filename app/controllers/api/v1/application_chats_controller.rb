class Api::V1::ApplicationChatsController < Api::V1::ApiController
  before_action :set_application

  def index
    @chats = @application.chats.all
    render json: @chats
  end


  def show
    @chat = @application.chats.find_by(number: params[:number])
    if @chat
      render json: @chat
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  def create
    retries ||= 3
    @chat = @application.chats.build
    @chat.number = @application.chats.count + 1
    if @chat.save
      render json: @chat, status: :created
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
      if @application.nil?
        raise ActiveRecord::RecordNotFound
      end
    end
end
