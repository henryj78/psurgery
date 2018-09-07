class ZipcodesController < ApplicationController
  require "browser"
  browser = Browser.new("Mozilla/5.0 (iPad; U; CPU OS 3_2_1 like Mac OS X; en-us) AppleWebKit/531.21.10 (KHTML, like Gecko) Mobile/7B405")

  #layout false, :only => :customer
  layout 'custom'


  def create
    #TODO Hijacked the create method
    switch = 0
    zipcode = params[:zipcode][:zip_code].to_i
    city = params[:zipcode][:zipcode_name].size
    city_name = params[:zipcode][:zipcode_name]

    #Zipcode and city field is empty
    if zipcode == 0 && city == 0
      redirect_to('https://lease.cosmeticsurgery.com/')
    else
      if zipcode != 0
        ccheck = Zipcode.validate_zipcode(zipcode)
        uri = Zipcode.find_customer_url(zipcode) if !ccheck.empty?
        switch = 1 if ccheck.empty?
      end

      if city != 0
        city_name = city_name.split("|")[0]
        ccheck = Zipcode.validate_city(city_name.strip.titleize)
        uri = Zipcode.find_customer_url_city(city_name.strip.titleize) if !ccheck.empty?
        switch = 2 if ccheck.empty?
      end

      if ccheck.empty?
        flash[:notice] = 'Invalid zipcode try again ... ' if switch == 1
        flash[:notice] = 'Invalid City try again .... ' if switch == 2
        redirect_to(root_url)
      end

      if uri.nil? && ccheck.nil?
        redirect_to('https://lease.cosmeticsurgery.com/')
      end

      if uri.nil? && !ccheck.empty?
        redirect_to('https://lease.cosmeticsurgery.com/')
      end

      if !uri.nil? && !ccheck.empty? || ccheck.nil?
        Zipcode.write_device(browser, uri.id)
        redirect_to(uri.customer_url.to_s)
      end
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
