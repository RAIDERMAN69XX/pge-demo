require 'net/https'
require 'uri'

class MeterReadingController < ApplicationController
  def index
    # Nothing dynamic for now, just get the meter reading from Max's home...
    url = URI.encode('http://my.idigi.com/ws/XbeeAttributeDataCore?condition=xeEndpointId= 1 and xcClusterType= 0 and xcClusterId= 1794 and xaAttributeId= 1024')
    username = 'slalomdigital'
    password = 'Mogu2l4m!'

    uri = URI.parse(url)

    http = Net::HTTP.new(uri.host, uri.port)
    # I was going to use HTTPS, but it's F__king way to complicated to do it right.
    #http.use_ssl = true
    #http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(uri.request_uri)
    request.basic_auth(username, password)
    request['Accept'] = 'application/json'
    response = http.request(request)

    respond_to do |format|
      format.json { render json: response.body }
    end
  end

end
