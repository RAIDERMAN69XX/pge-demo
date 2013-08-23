class PriceCluster < ActiveRecord::Base
  attr_accessible :currency, :device_mac_id, :meter_mac_id, :price, :rate_label, :tier, :timestamp, :trailing_digits
end
