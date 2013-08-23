class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :device_mac_id
      t.integer :meter_mac_id
      t.timestamp :timestamp
      t.integer :id
      t.string :text
      t.boolean :confirmation_required
      t.boolean :confirmed
      t.integer :queue

      t.timestamps
    end
  end
end
