class CreateCurrentSummations < ActiveRecord::Migration
  def change
    create_table :current_summations do |t|
      t.integer :device_mac_id
      t.integer :meter_mac_id
      t.timestamp :timestamp
      t.integer :summation_delivered
      t.integer :summation_received
      t.integer :multiplier
      t.integer :divisor
      t.integer :digits_right
      t.integer :digits_left
      t.boolean :suppress_leading_zero

      t.timestamps
    end
  end
end
