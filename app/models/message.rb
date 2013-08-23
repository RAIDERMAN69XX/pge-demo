class Message < ActiveRecord::Base
  attr_accessible :confirmation_required, :confirmed, :device_mac_id, :id, :meter_mac_id, :queue, :text, :timestamp
end
