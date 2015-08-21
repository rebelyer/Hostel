class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.belongs_to :client, index: true
      t.belongs_to :room, index: true
      t.integer :adults_number
      t.integer :children_number
      t.date :beginning
      t.date :end
      t.datetime :reservation_date
      t.decimal :discount, precision: 2, scale: 2

      t.timestamps null: false
    end
  end
end
