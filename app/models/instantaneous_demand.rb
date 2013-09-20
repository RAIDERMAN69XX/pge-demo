class InstantaneousDemand < ActiveRecord::Base
  attr_accessible :demand, :device_mac_id, :digits_left, :digits_right, :divisor, :meter_mac_id, :multiplier, :suppress_leading_zero, :timestamp
end
