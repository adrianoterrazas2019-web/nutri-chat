puts "Cleaning database..."

Chat.destroy_all
Meal.destroy_all
UserInformation.destroy_all
User.destroy_all

puts "Creating demo user..."

user = User.create!(
  email: "example@email.com",
  password: "hello12345"
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

chat_messages = {
  "Protein Oatmeal" => [
    { role: "user",      content: "Is this oatmeal enough protein for a morning workout?" },
    { role: "assistant", content: "Yes! With 30g of protein it's a solid pre- or post-workout breakfast. The oats also give you slow-releasing carbs for sustained energy." },
    { role: "user",      content: "Should I add anything to make it even better?" },
    { role: "assistant", content: "You could stir in a tablespoon of almond butter for healthy fats, or top with a banana for extra potassium — both help with muscle recovery." }
  ],
  "Tofu Rice Bowl" => [
    { role: "user",      content: "How can I increase the protein in this bowl without adding meat?" },
    { role: "assistant", content: "Easy options: add edamame (extra ~9g per 100g), swap the sesame sauce for a peanut-based one with extra tofu, or sprinkle some hemp seeds on top." },
    { role: "user",      content: "Does tofu count as a complete protein?" },
    { role: "assistant", content: "Yes — tofu is one of the few plant proteins that contains all nine essential amino acids, making it an excellent meat substitute for muscle building." }
  ],
  "Greek Yogurt Snack" => [
    { role: "user",      content: "Is this snack good for my muscle-building goal?" },
    { role: "assistant", content: "Definitely. Greek yogurt is rich in casein, a slow-digesting protein that's especially useful before bed for overnight muscle repair." },
    { role: "user",      content: "The sugar content seems high — is the honey a problem?" },
    { role: "assistant", content: "14g of sugar is moderate. If you want to lower it, use a drizzle of honey instead of a tablespoon, or switch to a handful of blueberries for natural sweetness with more antioxidants." }
  ]
}

meals.each do |meal_data|
  meal = Meal.new(meal_data)
  meal.user = user
  meal.save!

  chat = Chat.create!(
    title: "#{meal.title} Chat",
    meal: meal
  )

  (chat_messages[meal.title] || []).each do |msg|
    Message.create!(chat: chat, role: msg[:role], content: msg[:content])
  end
end

puts "Seeds completed!"
