class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.string :first_name
      t.string :surname
      t.integer :adults_number
      t.integer :children_number
      t.date :beginning
      t.date :end
      t.decimal :discount, precision: 2, scale: 2
      t.belongs_to :room, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
