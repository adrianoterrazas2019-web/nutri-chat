class MessagesController < ApplicationController
  SYSTEM_PROMPT = <<~PROMPT
    You are a health assistant and expert nutrition.
    If the user asks for advice, suggest alterations to the current meal
    so it is more alligned to the user's profile.
    After making a suggestion of meal, always ask if user wants to add the
    suggestion as a new meal to their meals. Then create it with the tool.

    You have access to tools:
      - Create a new meal based on the suggestion given to the user

    Answer concisely in Markdown.
    Meal informations and the user profile are:
  PROMPT

  def create
    @chat = Chat.find(params[:chat_id])
    @meal = @chat.meal

    @message = Message.new(message_params)
    @message.chat = @chat
    @message.role = "user"

    if @message.save
      @ruby_llm_chat = RubyLLM.chat
      build_conversation_history
      @ruby_llm_chat.with_tool(CreateMealFromSuggestionTool.new(user: current_user))
      response = @ruby_llm_chat.with_instructions("SYSTEM_PROMPT #{get_meal_information} #{get_user_profile}").ask(@message.content)
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
    {
      age: Date.today.year - current_user.user_information.birthday.year,
      goal: current_user.user_information.goal,
      height: current_user.user_information.height,
      restrictions: current_user.user_information.restrictions,
      weight: current_user.user_information.weight
    }
  end

  def get_meal_information
    {
      title: @meal.title,
      description: @meal.description,
      calories_kcal: @meal.calories_kcal,
      carbohydrates_g: @meal.carbohydrates_g,
      protein_g: @meal.protein_g,
      contains_gluten: @meal.contains_gluten,
      contains_lactose: @meal.contains_lactose,
      nutri_score: @meal.nutri_score,
      fat_g: @meal.fat_g,
      sugar_g: @meal.sugar_g
    }
  end

  def build_conversation_history
    @chat.messages.each do |message|
      @ruby_llm_chat.add_message({ role: message.role, content: message.content })
    end
  end
end
