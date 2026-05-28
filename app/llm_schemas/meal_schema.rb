class MealSchema < RubyLLM::Schema
  string :title, description: "Title or very brief description of the meal"
  integer :calories_kcal, description: "Calories in kCal"
  number :protein_g, description: "Protein for the whole meal in g"
  number :carbohydrates_g, description: "Carbohydrates for the whole meal in g"
  number :sugar_g, description: "Amount of sugar for the whole meal in g"
  number :fat_g, description: "Amount of fat for the whole meal in g"

  string :nutri_score, enum: %w[A B C D E unknown], description: "Estimated European Nutri-Score"

  boolean :contains_gluten
  boolean :contains_lactose
end
