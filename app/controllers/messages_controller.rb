class MessagesController < ApplicationController
  SYSTEM_PROMPT = <<~PROMPT
    You are an expert nutrition assistant.

    Analyze the user's meal and estimate:
    calories, protein, carbohydrates, sugar, fat,
    Nutri-score, allergens, gluten, and lactose.
    Estimate nutrition for the user's meal using typical serving sizes when exact brand,
    restaurant, or portion size is missing.

    Return only structured data matching the schema.
    Mark uncertainty with certainty and notes.
  PROMPT
  
  def create
    @chat = current_user.chats.find(params[:chat_id])
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

  def message_params
    params.require(:message).permit(:content)
  end
end
