class CreateCurrentSummations < ActiveRecord::Migration
  def change
    create_table :current_summations do |t|
      t.string :device_mac_id
      t.string :meter_mac_id
      t.timestamp :timestamp
      t.integer :summation_delivered, :limit => 8
      t.integer :summation_received, :limit => 8
      t.integer :multiplier, :limit => 8
      t.integer :divisor, :limit => 8
      t.integer :digits_right, :limit => 8
      t.integer :digits_left, :limit => 8
      t.boolean :suppress_leading_zero

      t.timestamps
    end
  end
end
