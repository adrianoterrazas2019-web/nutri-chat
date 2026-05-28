class ChatsController < ApplicationController
  def show
    @chat = Chat.find(params[:id])
    @meal = @chat.meal
    @message = Message.new
  end
end
