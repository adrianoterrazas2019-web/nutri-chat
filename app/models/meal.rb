class Meal < ApplicationRecord
  has_many :chats, dependent: :destroy
  belongs_to :user

  validates :title, :description, presence: true
end
