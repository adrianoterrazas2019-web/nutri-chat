class MessagesController < ApplicationController
  SYSTEM_PROMPT = <<~PROMPT
    You are a health assistant and expert nutrition.
    If the user asks for advice, suggest alterations to the current meal
    so it is more alligned to the user's profile informations.
    Answer concisely in Markdown.
    The meal description and the user profile informations are:
  PROMPT

  def create
    @chat = Chat.find(params[:chat_id])
    @meal = @chat.meal

    @message = Message.new(message_params)
    @message.chat = @chat
    @message.role = "user"
    @user_profile = get_user_profile

    if @message.save
      ruby_llm_chat = RubyLLM.chat
      response = ruby_llm_chat.with_instructions("SYSTEM_PROMPT #{@meal.description} #{@user_profile}").ask(@message.content)
      Message.create(role: "assistant", content: response.content, chat: @chat)
      @chat.generate_title_from_first_message
      redirect_to chat_path(@chat)
    else
      render chat_path(@chat), status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:chat).permit(message: :content)[:message]
  end

  def get_user_profile
    { age: Date.today.year - current_user.user_information.birthday.year,
      goal: current_user.user_information.goal,
      height: current_user.user_information.height,
      restrictions: current_user.user_information.restrictions,
      weight: current_user.user_information.weight
    }
  end
end
