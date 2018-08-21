class ZipcodesController < ApplicationController
  require "browser"
  browser = Browser.new("Mozilla/5.0 (iPad; U; CPU OS 3_2_1 like Mac OS X; en-us) AppleWebKit/531.21.10 (KHTML, like Gecko) Mobile/7B405")

  #layout false, :only => :customer
  layout 'custom'

  def create
    #TODO Hijacked the create method
    uri = Zipcode.find_customer_url(params[:zipcode][:zip_code].to_i)
    if uri.nil?
      redirect_to('https://lease.cosmeticsurgery.com/')
    else
       Zipcode.write_device(browser, uri.id)
       redirect_to(uri.customer_url.to_s)
    end
  end

  def aws_hits
  end

  def customer
    @zipcode = Zipcode.new
  begin
    latitude =  request.location.latitude
    longitude = request.location.longitude

    puts "Latitude" + " : " + latitude.to_s
    puts "Longitude" + " : " + longitude.to_s

    @ip = request.location.ip

    if latitude == 0 || longitude == 0
      # get zip screen
    else
      zip = Geocoder.search([latitude, longitude]).first.postal_code
      uri = Zipcode.find_customer_url(zip.to_i)
      Zipcode.write_device(browser, uri.id) if !uri.nil?
      redirect_to(uri.customer_url.to_s) if !uri.nil?
    end
    rescue StandardError => e
      puts "********************** rescue error"
      puts e.message
      puts e.backtrace.inspect
    end
  end


  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def zipcode_params
   params.require(:zipcode).permit(:zip_code, :latitude, :longitude, :county, :country, :state, :city, :zipcode_type)
  end
end
