class Room < ActiveRecord::Base
   has_many :reservations, dependent: :destroy

   accepts_nested_attributes_for :reservations
end
