class CreateInstantaneousDemands < ActiveRecord::Migration
  def change
    create_table :instantaneous_demands do |t|
      t.integer :device_mac_id, :limit => 16
      t.integer :meter_mac_id, :limit => 16
      t.timestamp :timestamp
      t.integer :demand
      t.integer :multiplier, :limit => 16
      t.integer :divisor, :limit => 16
      t.integer :digits_right, :limit => 16
      t.integer :digits_left, :limit => 16
      t.boolean :suppress_leading_zero

      t.timestamps
    end
  end
end
