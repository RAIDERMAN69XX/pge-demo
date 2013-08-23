require 'net/https'
require 'uri'
require 'nokogiri'

class MeterReadingController < ApplicationController
  def index
    # Todo: Capture the data from the meter and put in in to the database...
    doc = Nokogiri::XML(params['body'])

    meterMacId = doc.xpath("//MeterMacId").first.content


    respond_to do |format|
      format.xml { render status: :ok }
    end
  end

end
