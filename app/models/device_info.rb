class DeviceInfo < ActiveRecord::Base
  attr_accessible :date_code, :device_mac_id, :firmware_version, :hardware_version, :install_code, :manufacturer, :model_id
end
