class CreateNetworkInfos < ActiveRecord::Migration
  def change
    create_table :network_infos do |t|
      t.integer :device_mac_id
      t.integer :coordinator_mac_id
      t.integer :status
      t.string :description
      t.integer :status_code
      t.integer :extended_pan_id
      t.integer :channel
      t.integer :short_address
      t.integer :link_strength

      t.timestamps
    end
  end
end
