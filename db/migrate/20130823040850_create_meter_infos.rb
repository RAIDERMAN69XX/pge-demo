class CreateMeterInfos < ActiveRecord::Migration
  def change
    create_table :meter_infos do |t|
      t.column :device_mac_id, 'BIGINT UNSIGNED'
      t.integer :device_mac_id, :limit => 8
      t.column :meter_mac_id, 'BIGINT UNSIGNED'
      t.integer :meter_mac_id, :limit => 8
      t.column :meter_type, 'BIGINT UNSIGNED'
      t.integer :meter_type, :limit => 8
      t.string :nick_name
      t.string :account
      t.string :auth
      t.string :host
      t.boolean :enabled

      t.timestamps
    end
  end
end
