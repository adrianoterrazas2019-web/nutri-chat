class Meal < ApplicationRecord
  has_many :chats, dependent: :destroy

  validates :title, :description, presence: true
end
