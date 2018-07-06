class ZipcodesController < ApplicationController
  require "browser"
  browser = Browser.new("Mozilla/5.0 (iPad; U; CPU OS 3_2_1 like Mac OS X; en-us) AppleWebKit/531.21.10 (KHTML, like Gecko) Mobile/7B405")


  def create
    #TODO Hijacked the create method
    uri = Zipcode.find_customer_url(params[:zipcode][:zip_code].to_i)
    Zipcode.write_device(browser, uri.id) if !uri.nil?
    redirect_to(uri.customer_url.to_s) if !uri.nil?
  end


  def customer
    @zipcode = Zipcode.new
    @lat = request.location.latitude
    @long = request.location.longitude

    if @lat != 0
      # get doctor
    end
  end


  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def zipcode_params
   params.require(:zipcode).permit(:zip_code, :latitude, :longitute, :county, :country, :state, :city, :zipcode_type)
  end
end
