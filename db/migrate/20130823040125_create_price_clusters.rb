class CreatePriceClusters < ActiveRecord::Migration
  def change
    create_table :price_clusters do |t|
      t.integer :device_mac_id, :limit => 16
      t.integer :meter_mac_id, :limit => 16
      t.timestamp :timestamp
      t.integer :price, :limit => 16
      t.integer :currency, :limit => 16
      t.integer :trailing_digits, :limit => 16
      t.integer :tier, :limit => 16
      t.string :rate_label

      t.timestamps
    end
  end
end
