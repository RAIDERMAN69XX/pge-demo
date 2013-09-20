class CreateDeviceInfos < ActiveRecord::Migration
  def change
    create_table :device_infos do |t|
      t.string :device_mac_id
      t.string :install_code
      t.string :firmware_version
      t.string :hardware_version
      t.string :manufacturer
      t.string :model_id
      t.string :date_code

      t.timestamps
    end
  end
end
