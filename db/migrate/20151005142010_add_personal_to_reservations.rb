class AddPersonalToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :email_address, :string
    add_column :reservations, :phone_number, :integer
  end
end
