class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.integer :room_number
      t.integer :beds_number
      t.decimal :price_per_adult, precision: 5, scale: 2
      t.decimal :price_per_child, precision: 5, scale: 2

      t.timestamps null: false
    end
  end
end
