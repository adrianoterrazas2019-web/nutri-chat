class ChatsController < ApplicationController
  def show
    @chat = Chat.find(params[:id])
    @meal = @chat.meal
    @message = Message.new
  end

  def create
    @meal = Meal.find(params[:meal_id])

    @chat = Chat.new(title: Chat::DEFAULT_TITLE)
    @chat.meal = @meal

    if @chat.save
      redirect_to chat_path(@chat)
    else
      @chats = @meal.chats.where(user: current_user)
      render meal_path(@meal) # "meals/:id"
    end
  end
end
