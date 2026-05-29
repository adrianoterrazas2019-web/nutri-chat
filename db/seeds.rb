puts "Cleaning database..."

#Chat.destroy_all
#Meal.destroy_all
#UserInformation.destroy_all
#User.destroy_all

puts "Creating demo user..."

user = User.create!(
  email: "example@email.com",
  password: "password"
)

puts "Creating user information..."

UserInformation.create!(
  user: user,
  goal: "Build muscle",
  restrictions: "Vegetarian",
  birthday: Date.new(1998, 5, 12),
  weight: 74,
  height: 180
)

puts "Creating meals + chats..."

meals = [

  {
    title: "Protein Oatmeal",
    description: "Oats with berries and protein powder.",
    calories_kcal: 420,
    carbohydrates_g: 45,
    protein_g: 30,
    contains_gluten: true,
    contains_lactose: false,
    fat_g: 9,
    sugar_g: 8,
    nutri_score: "A"
  },

  {
    title: "Tofu Rice Bowl",
    description: "Rice, tofu, vegetables, sesame sauce.",
    calories_kcal: 650,
    carbohydrates_g: 62,
    protein_g: 35,
    contains_gluten: true,
    contains_lactose: false,
    fat_g: 18,
    sugar_g: 6,
    nutri_score: "B"
  },

  {
    title: "Greek Yogurt Snack",
    description: "Greek yogurt with nuts and honey.",
    calories_kcal: 300,
    carbohydrates_g: 18,
    protein_g: 20,
    contains_gluten: true,
    contains_lactose: true,
    fat_g: 12,
    sugar_g: 14,
    nutri_score: "B"
  }
]

meals.each do |meal_data|
  meal = Meal.new(meal_data)
  meal.user = user
  meal.save!

  Chat.create!(
    title: "#{meal.title} Chat",
    meal: meal
  )
end

puts "Seeds completed!"
