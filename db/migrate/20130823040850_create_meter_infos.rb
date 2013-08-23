class CreateMeterInfos < ActiveRecord::Migration
  def change
    create_table :meter_infos do |t|
      t.integer :device_mac_id
      t.integer :meter_mac_id
      t.integer :meter_type
      t.string :nick_name
      t.string :account
      t.string :auth
      t.string :host
      t.boolean :enabled

      t.timestamps
    end
  end
end
