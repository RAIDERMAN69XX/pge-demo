class NetworkInfo < ActiveRecord::Base
  attr_accessible :channel, :coordinator_mac_id, :description, :device_mac_id, :extended_pan_id, :link_strength, :short_address, :status, :status_code
end
