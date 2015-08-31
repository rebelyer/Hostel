class Client < ActiveRecord::Base
  has_many :reservations, dependent: :destroy
  has_many :rooms, through: :reservations

#  validates :name, :surname, :phone_number, :email_adress, presence: true
end
