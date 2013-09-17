class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :device_mac_id, :limit => 16
      t.integer :meter_mac_id, :limit => 16
      t.timestamp :timestamp
      t.string :text
      t.boolean :confirmation_required
      t.boolean :confirmed
      t.integer :queue

      t.timestamps
    end
  end
end
