class ZipcodesController < ApplicationController
  require "browser"
  browser = Browser.new("Mozilla/5.0 (iPad; U; CPU OS 3_2_1 like Mac OS X; en-us) AppleWebKit/531.21.10 (KHTML, like Gecko) Mobile/7B405")
  #layout false, :only => :customer
  layout 'custom'

  def create
    #TODO Hijacked the create method

    @zipcode = Zipcode.new

     @browser_lat =  params[:zipcode][:latitude]
     @browser_long = params[:zipcode][:longitude]




    # ************************
    puts "******************************** @browser_lat : " + @browser_lat
    puts "******************************** @browser_long : " + @browser_long


      if params[:zipcode][:zipcode_name].nil?
        if @browser_lat != "" || @browser_long != ""
          @county_zip = browser_loc(@browser_lat,@browser_long )
          @county = ""
          initilize(@county_zip,@county)
          change_url(@uri)
        end
      else
        initilize(params[:zipcode][:zip_code],params[:zipcode][:zipcode_name])
        change_url(@uri)
      end
   end


  def aws_hits
    @zipcode = Zipcode.new
  end


  def customer
    @zipcode = Zipcode.new
  begin
    @req = request.location
    latitude =  @req.latitude
    longitude = @req.longitude
    @ip = @req.ip
    zip = @req.postal

    if latitude.to_i == 0 || longitude.to_i == 0
      # get zip screen
    else
      uri = Zipcode.find_customer_url(zip.to_i)
      Zipcode.write_device(browser, uri.id) if !uri.nil?
      redirect_to(uri.customer_url.to_s) if !uri.nil?
    end
    rescue StandardError => e
      puts e.message
      #puts e.backtrace.inspect
    end
  end

  private

  def initilize(zipcode, city)

    if zipcode.size == 0 and city.size == 0
     @uri = 'https://lease.cosmeticsurgery.com/'
    else
     @uri = Zipcode.validate_input(city, zipcode)
    end
  end

  def browser_loc(lat, long)

    browser_lat = lat[0..3]
    browser_long = long[0..5]
    browser_long = browser_long[0..4] if  browser_long[3] == "."
    lat = browser_lat[0..2]
    latlng = browser_long[0..4]



    county_zip = Zipcode.where("latitude like ? and longitude like ?","%#{browser_lat}%", "%#{browser_long}%")
    county_zip = Zipcode.where("latitude like ? and longitude like ?","%#{lat}%", "%#{latlng}%") if county_zip.empty?


    puts "******************************** browser_lat : " + browser_lat
    puts "******************************** browser_long : " + browser_long



    if !county_zip.empty?
      county_map = county_zip.map{|n| n.county}.first
      county_state = county_zip.map{|n| n.state}.first

      czip = Zone.where(county: county_map, state: county_state)
      xzip = Zipcode.where(county: czip[0].county, state: county_state)
      if !xzip.empty?
         Zipcode.write_device(browser, czip[0].customer_id)
         county_zip = xzip[0].zip_code
      end
      return county_zip  if !czip[0].customer_id.nil?
    end
   else
     county_zip = nil
     return county_zip
  end

  def change_url(uri)
    if uri.nil?
     @uri = 'https://lease.cosmeticsurgery.com/'
    end
    redirect_to(uri)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def zipcode_params
   params.require(:zipcode).permit(:zip_code, :latitude, :longitude, :county, :country, :state, :city, :zipcode_type)
  end
end
