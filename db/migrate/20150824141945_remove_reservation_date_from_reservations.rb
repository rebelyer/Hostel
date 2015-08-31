class RemoveReservationDateFromReservations < ActiveRecord::Migration
  def change
    remove_column :reservations, :reservation_date, :datetime
  end
end
