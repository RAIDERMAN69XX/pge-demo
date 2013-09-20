class CreateNetworkInfos < ActiveRecord::Migration
  def change
    create_table :network_infos do |t|
      t.string :device_mac_id
      t.string :meter_mac_id
      t.string :status
      t.string :description
      t.integer :status_code
      t.string :extended_pan_id
      t.integer :channel
      t.string :short_address
      t.integer :link_strength

      t.timestamps
    end
  end
end
