require 'test_helper'

class MeterReadingControllerTest < ActionController::TestCase
  test "should allow valid meter data to be posted" do
    @request.env["RAW_POST_DATA"] = '<?xml version="1.0"?>
<RainForest macId="0xf0ad4e00ce69" timestamp="1355292588s">
  <NetworkInfo>
    <DeviceMacId>0xd8d5b90000000c3b</DeviceMacId>
    <Status>Connected</Status>
    <MeterMacId>0x0013500100fe9e32</MeterMacId>
    <ExtPanId>0x7fffffffffffffff</ExtPanId>
    <ShortAddr>0x0000ffff</ShortAddr>
    <Channel>25</Channel>
    <LinkStrength>100</LinkStrength>
  </NetworkInfo>
  <DeviceInfo>
    <DeviceMacId>0xd8d5b90000000c3b</DeviceMacId>
    <InstallCode>0x719bafe583879739</InstallCode>
    <LinkKeyHigh>b97897b005f1cdad</LinkKeyHigh>
    <LinkKeyLow>acf7fc84874bb841</LinkKeyLow>
    <FWVersion>1.4.23 (5099)</FWVersion>
    <HWVersion>3.2.3</HWVersion>
    <Manufacturer>Rainforest Automation, I</Manufacturer>
    <ModelId>RFA-Z109 EAGLE</ModelId>
    <DateCode>20121201EC051052</DateCode>
  </DeviceInfo>
  <InstantaneousDemand>
    <DeviceMacId>0xd8d5b90000000c3b</DeviceMacId>
    <MeterMacId>0x0013500100fe9e32</MeterMacId>
    <Demand>0x00000000000001eb</Demand>
    <TimeStamp>0x19bb9510</TimeStamp>
    <Multiplier>0x00000001</Multiplier>
    <Divisor>0x000003e8</Divisor>
    <DigitsRight>0x00000003</DigitsRight>
    <DigitsLeft>0x0000000f</DigitsLeft>
    <SuppressLeadingZero>0x0001</SuppressLeadingZero>
  </InstantaneousDemand>
  <CurrentSummation>
    <DeviceMacId>0xd8d5b90000000c3b</DeviceMacId>
    <MeterMacId>0x0013500100fe9e32</MeterMacId>
    <SummationDelivered>0x0000000000972a9e</SummationDelivered>
    <SummationReceived>0x0000000000000000</SummationReceived>
    <Multiplier>0x00000001</Multiplier>
    <Divisor>0x000003e8</Divisor>
    <DigitsRight>0x00000003</DigitsRight>
    <DigitsLeft>0x0000000f</DigitsLeft>
    <SuppressLeadingZero>0x01</SuppressLeadingZero>
  </CurrentSummation>
  <PriceCluster>
    <DeviceMacId>0xd8d5b90000000c3b</DeviceMacId>
    <MeterMacId>0x0013500100fe9e32</MeterMacId>
    <Price>0x00000000</Price>
    <Currency>0x0348</Currency>
    <TrailingDigits>0x04</TrailingDigits>
    <Tier>0x00</Tier>
    <RateLabel></RateLabel>
  </PriceCluster>
  <MessageCluster>
    <DeviceMacId>0xd8d5b90000000c3b</DeviceMacId>
    <MeterMacId>0x0013500100fe9e32</MeterMacId>
    <Id>0x0000</Id>
    <Text></Text>
    <ConfirmationRequired>N</ConfirmationRequired>
    <Confirmed>N</Confirmed>
    <Queue>active</Queue>
  </MessageCluster>
  <MeterInfo>
    <DeviceMacId>0xd8d5b90000000c3b</DeviceMacId>
    <MeterMacId>0x0013500100fe9e32</MeterMacId>
    <Type>0x0000</Type>
    <Nickname></Nickname>
    <Account></Account>
    <Auth></Auth>
    <Host></Host>
    <Enabled>0x00</Enabled>
  </MeterInfo>
</RainForest>'
    post :create,  { :format => :xml }
    assert_response :success
  end

  test "should create a valid DeviceInfo record when one is posted" do
    @request.env["RAW_POST_DATA"] = '<?xml version="1.0"?>
<RainForest macId="0xf0ad4e00ce69" timestamp="1355292588s">
  <DeviceInfo>
    <DeviceMacId>0x1</DeviceMacId>
    <InstallCode>0x2</InstallCode>
    <LinkKeyHigh>1234</LinkKeyHigh>
    <LinkKeyLow>5678</LinkKeyLow>
    <FWVersion>1.4.23 (5099)</FWVersion>
    <HWVersion>3.2.3</HWVersion>
    <Manufacturer>Rainforest Automation, I</Manufacturer>
    <ModelId>RFA-Z109 EAGLE</ModelId>
    <DateCode>20121201EC051052</DateCode>
  </DeviceInfo>
</RainForest>'
    post :create,  { :format => :xml }
    assert_response :success
    assert !DeviceInfo.find_all_by_device_mac_id("0x1").empty?
    deviceInfo = DeviceInfo.find_all_by_device_mac_id("0x1").last

    assert_equal("0x1", deviceInfo.device_mac_id)
    assert_equal("0x2", deviceInfo.install_code)
    assert_equal("1.4.23 (5099)", deviceInfo.firmware_version)
    assert_equal("3.2.3", deviceInfo.hardware_version)
    assert_equal("Rainforest Automation, I", deviceInfo.manufacturer)
    assert_equal("RFA-Z109 EAGLE", deviceInfo.model_id)
    assert_equal("20121201EC051052", deviceInfo.date_code)
  end

  test "should create a valid NetworkInfo record when one is posted" do
    @request.env["RAW_POST_DATA"] = '<?xml version="1.0"?>
<RainForest macId="0xf0ad4e00ce69" timestamp="1355292588s">
  <NetworkInfo>
    <DeviceMacId>0x2</DeviceMacId>
    <Status>Connected</Status>
    <MeterMacId>0x3</MeterMacId>
    <ExtPanId>0x7</ExtPanId>
    <ShortAddr>0x8</ShortAddr>
    <Channel>25</Channel>
    <LinkStrength>100</LinkStrength>
  </NetworkInfo>
</RainForest>'
    post :create,  { :format => :xml }
    assert_response :success
    assert !NetworkInfo.find_all_by_device_mac_id("0x2").empty?
    networkInfo = NetworkInfo.find_all_by_device_mac_id("0x2").last

    assert_equal("Connected", networkInfo.status)
    assert_equal("0x2", networkInfo.device_mac_id)
    assert_equal("0x3", networkInfo.meter_mac_id)
    assert_equal("0x7",networkInfo.extended_pan_id)
    assert_equal("0x8", networkInfo.short_address)
    assert_equal(25, networkInfo.channel)
    assert_equal(100, networkInfo.link_strength)
  end

  test "should create a valid Instantaneous Demand record when one is posted" do
    @request.env["RAW_POST_DATA"] = '<?xml version="1.0"?>
<RainForest macId="0xf0ad4e00ce69" timestamp="1355292588s">
  <InstantaneousDemand>
    <DeviceMacId>0x02</DeviceMacId>
    <MeterMacId>0x03</MeterMacId>
    <Demand>0x00000000000001</Demand>
    <TimeStamp>0x19bb9510</TimeStamp>
    <Multiplier>0x00000002</Multiplier>
    <Divisor>0x000001</Divisor>
    <DigitsRight>0x00000003</DigitsRight>
    <DigitsLeft>0x00000004</DigitsLeft>
    <SuppressLeadingZero>0x0001</SuppressLeadingZero>
  </InstantaneousDemand>
</RainForest>'
    post :create,  { :format => :xml }
    assert_response :success

    assert !InstantaneousDemand.find_all_by_device_mac_id("0x02").empty?
    instantaneousDemand = InstantaneousDemand.find_all_by_device_mac_id("0x02").last

    assert_equal("0x02", instantaneousDemand.device_mac_id)
    assert_equal("0x03", instantaneousDemand.meter_mac_id)
    assert_equal(1, instantaneousDemand.demand)
    assert_equal(2, instantaneousDemand.multiplier)
    assert_equal(1, instantaneousDemand.divisor)
    assert_equal(3, instantaneousDemand.digits_right)
    assert_equal(4, instantaneousDemand.digits_left)
    assert_equal(true, instantaneousDemand.suppress_leading_zero)

    @request.env["RAW_POST_DATA"] = '<?xml version="1.0"?>
<RainForest macId="0xf0ad4e00ce69" timestamp="1355292588s">
  <InstantaneousDemand>
    <DeviceMacId>0x03</DeviceMacId>
    <MeterMacId>0x03</MeterMacId>
    <Demand>0x00000000000001</Demand>
    <TimeStamp>0x19bb9510</TimeStamp>
    <Multiplier>0x00000002</Multiplier>
    <Divisor>0x000001</Divisor>
    <DigitsRight>0x00000003</DigitsRight>
    <DigitsLeft>0x00000004</DigitsLeft>
    <SuppressLeadingZero>0x0000</SuppressLeadingZero>
  </InstantaneousDemand>
</RainForest>'
    post :create,  { :format => :xml }
    assert_response :success
    assert !InstantaneousDemand.find_all_by_device_mac_id("0x03").empty?
    instantaneousDemand = InstantaneousDemand.find_all_by_device_mac_id("0x03").last

    assert_equal(false, instantaneousDemand.suppress_leading_zero)

  end

  test "should create a valid Current Summation record when one is posted" do
    @request.env["RAW_POST_DATA"] = '<?xml version="1.0"?>
<RainForest macId="0xf0ad4e00ce69" timestamp="1355292588s">
  <CurrentSummation>
    <DeviceMacId>0x2</DeviceMacId>
    <MeterMacId>0x3</MeterMacId>
    <SummationDelivered>0x0000000000000006</SummationDelivered>
    <SummationReceived>0x0000000000000005</SummationReceived>
    <Multiplier>0x00000003</Multiplier>
    <Divisor>0x000003ef</Divisor>
    <DigitsRight>0x00000003</DigitsRight>
    <DigitsLeft>0x000000ff</DigitsLeft>
    <SuppressLeadingZero>0x01</SuppressLeadingZero>
  </CurrentSummation>
</RainForest>'
    post :create,  { :format => :xml }
    assert_response :success
    @request.env["RAW_POST_DATA"] = '<?xml version="1.0"?>
<RainForest macId="0xf0ad4e00ce69" timestamp="1355292588s">
  <CurrentSummation>
    <DeviceMacId>0x4</DeviceMacId>
    <MeterMacId>0x3</MeterMacId>
    <SummationDelivered>0x0000000000000006</SummationDelivered>
    <SummationReceived>0x0000000000000005</SummationReceived>
    <Multiplier>0x00000003</Multiplier>
    <Divisor>0x000008</Divisor>
    <DigitsRight>0x00000003</DigitsRight>
    <DigitsLeft>0x000000f</DigitsLeft>
    <SuppressLeadingZero>0x00</SuppressLeadingZero>
  </CurrentSummation>
</RainForest>'
    post :create,  { :format => :xml }
    assert_response :success

    assert !CurrentSummation.find_all_by_device_mac_id("0x2").empty?
    currentSummation = CurrentSummation.find_all_by_device_mac_id("0x2").last

    assert_equal("0x2", currentSummation.device_mac_id)
    assert_equal("0x3", currentSummation.meter_mac_id)
    assert_equal(6,currentSummation.summation_delivered)
    assert_equal(5, currentSummation.summation_received)
    assert_equal(1007, currentSummation.divisor)
    assert_equal(3, currentSummation.digits_right)
    assert_equal(255, currentSummation.digits_left)
    assert_equal(true, currentSummation.suppress_leading_zero)

    assert !CurrentSummation.find_all_by_device_mac_id("0x4").empty?
    currentSummation = CurrentSummation.find_all_by_device_mac_id("0x4").last
    assert_equal(false, currentSummation.suppress_leading_zero)
  end

end
