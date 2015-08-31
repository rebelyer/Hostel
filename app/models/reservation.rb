class Reservation < ActiveRecord::Base
  belongs_to :client
  belongs_to :room

  validates :client_id, :room_id, :adults_number,  presence: true
end
