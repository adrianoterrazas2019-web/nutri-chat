class MealsController < ApplicationController
  def index
    @meals = Meal.all
  end

  private

  def set_meal
    @meal = Meal.find(params[:id])
  end
end
