class MealsController < ApplicationController
  before_action :set_meal, only: [ :show, :destroy ]
  def index
    @meals = Meal.all
  end

  def show
  end

  def new
    @meal = Meal.new
  end

  def create
    prompt = helpers.sanitize(get_description, tags: [], attributes: []).squish.truncate(200)
    chat = RubyLLM.chat
    response = chat.with_schema(MealSchema).ask("Estimate the nutritional information based on the given schema for the meal: #{prompt}")

    @meal = Meal.new(response.content)
    @meal.description = get_description

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

  def get_description
    params.require(:meal).permit(:description)
  end
end
