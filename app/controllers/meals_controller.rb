class MealsController < ApplicationController
  before_action :set_meal, only: [ :show, :destroy ]
  def index
    @meals = Meal.all
  end

  def show
  end

  def destroy
   @meal.destroy
   redirect_to meals_path
  end

  private

  def set_meal
    @meal = Meal.find(params[:id])
  end
end
