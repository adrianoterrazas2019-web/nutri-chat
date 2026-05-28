class User < ApplicationRecord
  has_many :chats, dependent: :destroy
  has_many :meals, through: :chats, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :user_information,
          dependent: :destroy
end
