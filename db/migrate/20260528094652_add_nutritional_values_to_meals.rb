class AddNutritionalValuesToMeals < ActiveRecord::Migration[8.1]
  def change
    add_column :meals, :calories_kcal, :integer
    add_column :meals, :protein_g, :decimal
    add_column :meals, :carbohydrates_g, :decimal
    add_column :meals, :sugar_g, :decimal
    add_column :meals, :fat_g, :decimal
    add_column :meals, :nutri_score, :string
    add_column :meals, :contains_gluten, :boolean
    add_column :meals, :contains_lactose, :boolean
  end
end
