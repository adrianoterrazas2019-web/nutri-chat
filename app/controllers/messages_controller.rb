class MessagesController < ApplicationController
  SYSTEM_PROMPT = <<~PROMPT
    You are a health assistant and expert nutrition.
    The user profile is: #{get_user_profile}
    If the user asks for advice, suggest alterations to the current meal
    so it is more alligned to the user's profile informations.
  PROMPT

  def create
    @chat = Chat.find(params[:chat_id])
    @meal = @chat.meal

    @message = Message.new(message_params)
    @message.chat = @chat
    @message.role = "user"

    if @message.save
      ruby_llm_chat = RubyLLM.chat
      response = ruby_llm_chat.with_instructions(SYSTEM_PROMPT).ask(@message.content)
      Message.create(role: "assistant", content: response.content, chat: @chat)

      redirect_to chat_path(@chat)
    else
      render "chats/show", status: :unprocessable_entity
    end
  end

  private

  require "date"

  def message_params
    params.require(:message).permit(:content)
  end

  def get_user_profile
    { birthyear: current_user.user_information.birthday.split("-").first,
      goal: current_user.goal,
      height: current_user.height,
      restrictions: current_user.restrictions,
      weight: current_user.weight
    }
  end
end
