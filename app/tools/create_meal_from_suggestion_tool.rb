class CreateMealFromSuggestionTool < RubyLLM::Tool
  SYSTEM_PROMPT = <<~PROMPT
    You are an expert in nutrition.
    Analyze the user's meal and estimate the values given in the schema.
    Estimate nutrition for the user's meal using typical serving sizes when exact brand,
    restaurant, or portion size is missing. The meal description is:
  PROMPT

  description "Creates a new meal based on the suggestion given to the user"
  param :meal_description, desc: "Last suggested meal accepted by the user"

  def initialize(user:)
    @user = user
  end

  def execute(meal_description:)
    chat = RubyLLM.chat
    response = chat.with_schema(MealSchema).ask("#{SYSTEM_PROMPT} #{meal_description}")
    @meal = Meal.new(response.content)
    @meal.description = meal_description
    @meal.user = @user
    @meal.save
  end
end
