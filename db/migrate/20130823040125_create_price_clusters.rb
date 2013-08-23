class CreatePriceClusters < ActiveRecord::Migration
  def change
    create_table :price_clusters do |t|
      t.integer :device_mac_id
      t.integer :meter_mac_id
      t.timestamp :timestamp
      t.integer :price
      t.integer :currency
      t.integer :trailing_digits
      t.integer :tier
      t.string :rate_label

      t.timestamps
    end
  end
end
