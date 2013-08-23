class CreateInstantaneousDemands < ActiveRecord::Migration
  def change
    create_table :instantaneous_demands do |t|
      t.integer :device_mac_id
      t.integer :meter_mac_id
      t.timestamp :timestamp
      t.integer :demand
      t.integer :multiplier
      t.integer :divisor
      t.integer :digits_right
      t.integer :digits_left
      t.boolean :suppress_leading_zero

      t.timestamps
    end
  end
end
