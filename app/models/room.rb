class Room < ActiveRecord::Base
  has_many :reservations, dependent: :destroy
  has_many :clients, through: :reservations

  validates :room_number, :beds_number, :price_per_adult, :price_per_child, presence: true
end
