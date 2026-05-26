class CreateMeals < ActiveRecord::Migration[8.1]
  def change
    create_table :meals do |t|
      t.string :title
      t.string :description
      t.text :nutritional_info
      t.text :system_prompt

      t.timestamps
    end
  end
end
