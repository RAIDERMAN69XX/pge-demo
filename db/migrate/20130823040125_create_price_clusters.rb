class CreatePriceClusters < ActiveRecord::Migration
  def change
    create_table :price_clusters do |t|
      t.string :device_mac_id, :limit => 16
      t.string :meter_mac_id, :limit => 16
      t.timestamp :timestamp
      t.string :price, :limit => 16
      t.string :currency
      t.string :trailing_digits
      t.integer :tier, :limit => 16
      t.string :rate_label

      t.timestamps
    end
  end
end
