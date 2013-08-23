class MeterInfo < ActiveRecord::Base
  attr_accessible :account, :auth, :device_mac_id, :enabled, :host, :meter_mac_id, :meter_type, :nick_name
end
