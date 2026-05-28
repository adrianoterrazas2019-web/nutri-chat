class MealsController < ApplicationController
  before_action :set_meal, only: [ :show, :destroy ]
  def index
    @meals = Meal.all
  end

  def show
    @chats = @meal.chats
  end

  def new
    @meal = Meal.new
  end

  def create
    prompt = helpers.sanitize(meal_params, tags: [], attributes: []).squish.truncate(200)
    chat = RubyLLM.chat
    response = chat.with_schema(MealSchema).ask("
    You are a health assistant and expert nutrition.
    Analyze the user's meal and estimate the values given in the schema.
    Estimate nutrition for the user's meal using typical serving sizes when exact brand,
    restaurant, or portion size is missing. The meal description is: #{prompt}")

    @meal = Meal.new(response.content)
    @meal.description = meal_params[:description]
    @meal.user = current_user

    if @meal.save
      redirect_to meal_path(@meal)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
   @meal.destroy
   redirect_to meals_path
  end

  private

  def set_meal
    @meal = Meal.find(params[:id])
  end

  def meal_params
    params.require(:meal).permit(:description)
  end
end
