class CreateUserInformations < ActiveRecord::Migration[8.1]
  def change
    create_table :user_informations do |t|
      t.references :user, null: false, foreign_key: true
      t.string :goal
      t.text :restrictions
      t.date :birthday
      t.float :weight
      t.float :height

      t.timestamps
    end
  end
end
