class Client < ActiveRecord::Base
  has_many :reservations, dependent: :destroy
  has_many :rooms, through: :reservations
end
