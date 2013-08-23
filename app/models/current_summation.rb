class CurrentSummation < ActiveRecord::Base
  attr_accessible :device_mac_id, :digits_left, :digits_right, :divisor, :meter_mac_id, :multiplier, :summation_delivered, :summation_received, :suppress_leading_zero, :timestamp
end
