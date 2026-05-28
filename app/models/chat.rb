class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :meal
  has_many :messages, dependent: :destroy
end
