class ChangeReservation < ActiveRecord::Migration
  def change
    change_column :reservations, :phone_number, :integer, limit: 11
  end
end
