class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.string :surname
      t.integer :phone_number
      t.string :email_adress

      t.timestamps null: false
    end
  end
end
