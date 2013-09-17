require 'net/https'
require 'uri'
require 'nokogiri'

class MeterReadingController < ApplicationController
  def index
    # Parse the doc and if we are successful
    doc = Nokogiri::XML(params['body'])

    # Check for NetworkInfo
    networkInfo = doc.xpath("//NetworkInfo")
    if (!networkInfo.blank?)
      if !networkInfo.xpath("//Channel").blank?
        channel = networkInfo.xpath("//Channel").first.content
      end

      if !networkInfo.xpath("//MeterMacId").blank?
        meter_mac_id = networkInfo.xpath("//MeterMacId").first.content
      end

      if !networkInfo.xpath("//Description").blank?
        description = networkInfo.xpath("//Description").first.content
      end

      if !networkInfo.xpath("//DeviceMacId").blank?
        device_mac_id = networkInfo.xpath("//DeviceMacId").first.content
      end

      if !networkInfo.xpath("//ExtPanId").blank?
        extended_pan_id = networkInfo.xpath("//ExtPanId").first.content
      end

      if !networkInfo.xpath("//LinkStrength").blank?
        link_strength = networkInfo.xpath("//LinkStrength").first.content
      end

      if !networkInfo.xpath("//ShortAddr").blank?
        short_address = networkInfo.xpath("//ShortAddr").first.content
      end

      if !networkInfo.xpath("//Status").blank?
        status = networkInfo.xpath("//Status").first.content
      end

      if !networkInfo.xpath("//StatusCode").blank?
        status_code = networkInfo.xpath("//StatusCode").first.content
      end

      NetworkInfo.create(:channel => channel, :meter_mac_id => meter_mac_id, :description => description,
                         :device_mac_id => device_mac_id, :extended_pan_id => extended_pan_id,
                         :link_strength => link_strength, :short_address => short_address, :status => status,
                         :status_code => status_code)
    end


    # Check for DeviceInfo
    deviceInfo = doc.xpath("//DeviceInfo")
    if (!deviceInfo.blank?)
      if !deviceInfo.xpath("//DeviceMacId").blank?
        device_mac_id = deviceInfo.xpath("//DeviceMacId").first.content
      end

      if !deviceInfo.xpath("//InstallCode").blank?
        install_code = deviceInfo.xpath("//InstallCode").first.content
      end

      if !deviceInfo.xpath("//FWVersion").blank?
        firmware_version = deviceInfo.xpath("//FWVersion").first.content
      end

      if !deviceInfo.xpath("//HWVersion").blank?
        hardware_version = deviceInfo.xpath("//HWVersion").first.content
      end

      if !deviceInfo.xpath("//Manufacturer").blank?
        manufacturer = deviceInfo.xpath("//Manufacturer").first.content
      end

      if !deviceInfo.xpath("//ModelId").blank?
        model_id = deviceInfo.xpath("//ModelId").first.content
      end

      if !deviceInfo.xpath("//DateCode").blank?
        date_code = deviceInfo.xpath("//DateCode").first.content
      end

      DeviceInfo.create(:date_code => date_code, :device_mac_id => device_mac_id, :firmware_version => firmware_version,
                        :hardware_version => hardware_version, :install_code => install_code,
                        :manufacturer => manufacturer, :model_id => model_id)
    end

    # Check for InstantaneousDemand
    instantaneousDemand = doc.xpath("//InstantaneousDemand")
    if (!instantaneousDemand.blank?)
      if !instantaneousDemand.xpath("//DeviceMacId").blank?
        device_mac_id = instantaneousDemand.xpath("//DeviceMacId").first.content
      end

      if !instantaneousDemand.xpath("//MeterMacId").blank?
        meter_mac_id = instantaneousDemand.xpath("//MeterMacId").first.content
      end

      if !instantaneousDemand.xpath("//Demand").blank?
        demand = instantaneousDemand.xpath("//Demand").first.content.to_i(base=16)
      end

      if !instantaneousDemand.xpath("//TimeStamp").blank?
        timestamp = instantaneousDemand.xpath("//TimeStamp").first.content
      end

      if !instantaneousDemand.xpath("//Multiplier").blank?
        multiplier = instantaneousDemand.xpath("//Multiplier").first.content.to_i(base=16)
      end

      if !instantaneousDemand.xpath("//Divisor").blank?
        divisor = instantaneousDemand.xpath("//Divisor").first.content.to_i(base=16)
      end

      if !instantaneousDemand.xpath("//DigitsRight").blank?
        digits_right = instantaneousDemand.xpath("//DigitsRight").first.content.to_i(base=16)
      end

      if !instantaneousDemand.xpath("//DigitsLeft").blank?
        digits_left = instantaneousDemand.xpath("//DigitsLeft").first.content.to_i(base=16)
      end

      if !instantaneousDemand.xpath("//SuppressLeadingZero").blank?
        if instantaneousDemand.xpath("//SuppressLeadingZero").first.content.to_i(base=16) != 0
          suppress_leading_zero = true
        else
          suppress_leading_zero = false
        end
      end

      InstantaneousDemand.create(:demand => demand, :device_mac_id => device_mac_id, :digits_left => digits_left,
                                 :digits_right => digits_right, :divisor => divisor, :meter_mac_id => meter_mac_id,
                                 :multiplier => multiplier, :suppress_leading_zero => suppress_leading_zero,
                                 :timestamp => timestamp)
    end

    render :nothing => true
  end

end
