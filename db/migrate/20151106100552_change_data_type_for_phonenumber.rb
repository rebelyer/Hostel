class ChangeDataTypeForPhonenumber < ActiveRecord::Migration
   def change
      change_table :reservations do |t|
         t.change :phone_number, :string, limit: 12
      end
   end
end
