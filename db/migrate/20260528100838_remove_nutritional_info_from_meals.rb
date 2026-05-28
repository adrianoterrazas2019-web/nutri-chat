class RemoveNutritionalInfoFromMeals < ActiveRecord::Migration[8.1]
  def change
    remove_column :meals, :nutritional_info, :text
    remove_column :meals, :system_prompt, :text
  end
end
