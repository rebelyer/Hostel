class Room < ActiveRecord::Base
   validates :room_number, uniqueness: true
   has_many :reservations, dependent: :destroy

   accepts_nested_attributes_for :reservations
end
