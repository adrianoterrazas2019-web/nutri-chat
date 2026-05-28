puts "Cleaning database..."

Chat.destroy_all
Meal.destroy_all
UserInformation.destroy_all
User.destroy_all

puts "Creating demo user..."

user = User.create!(
  email: "demo@example.com",
  password: "password123"
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
    calories: 420,
    carbs: 45,
    protein: 30,
    contains_glucose: true,
    contains_lactose: false,
    fat: 9,
    sugar: 8,
    nutri_score: "A"
  },

  {
    title: "Tofu Rice Bowl",
    description: "Rice, tofu, vegetables, sesame sauce.",
    calories: 650,
    carbs: 62,
    protein: 35,
    contains_glucose: true,
    contains_lactose: false,
    fat: 18,
    sugar: 6,
    nutri_score: "B"
  },

  {
    title: "Greek Yogurt Snack",
    description: "Greek yogurt with nuts and honey.",
    calories: 300,
    carbs: 18,
    protein: 20,
    contains_glucose: true,
    contains_lactose: true,
    fat: 12,
    sugar: 14,
    nutri_score: "B"
  }
]

meals.each do |meal_data|
  meal = Meal.create!(meal_data)

  Chat.create!(
    title: "#{meal.title} Chat",
    meal: meal
  )
end

puts "Seeds completed!"
