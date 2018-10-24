class ZipcodesController < ApplicationController
  require "browser"
  browser = Browser.new("Mozilla/5.0 (iPad; U; CPU OS 3_2_1 like Mac OS X; en-us) AppleWebKit/531.21.10 (KHTML, like Gecko) Mobile/7B405")
  #layout false, :only => :customer
  layout 'custom'

  def create
    #TODO Hijacked the create method
    initilize(params[:zipcode][:zip_code],params[:zipcode][:zipcode_name])

    if @uri.nil?
      redirect_to(root_url)
      flash[:notice] = 'Invalid zipcode or city try again ... '
    else
      redirect_to(@uri)
    end
  end

  def aws_hits
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


  # Never trust parameters from the scary internet, only allow the white list through.
  def zipcode_params
   params.require(:zipcode).permit(:zip_code, :latitude, :longitude, :county, :country, :state, :city, :zipcode_type)
  end
end
