class Zipcode < ApplicationRecord
  # TODO Find Customer url from zip code
  # TODO Testing Development enviroment - zipcode
  # establish_connection :external_database

  #reverse_geocoded_by :latitude, :longitude
  #after_validation :reverse_geocode
  #after_validation :reverse_geocode

 geocoded_by :address

 def address
   [city, zip_code].compact.join(",")
 end

  def self.find_customer_url(search)
    county = Zipcode.where(zip_code: search)
    customer_url = Zipcode.find_url(county)
    return customer_url
  end

  #TODO make this more dry combine methods
  def self.find_customer_url_city(city)
    customer_url = nil
    county = Zipcode.where(city: city)

    if !county.empty?
      zone = Zone.where(county: county[0].county)
      if !zone.empty?
        if !zone[0].customer_id.nil?
          custid = zone[0].customer_id
          @cus_check = Customer.find(custid)
          Zipcode.covert_demo if @cus_check.status_id == 2
          customer_url = zone[0].customer if @cus_check.status_id != 3
        end
      end
      return customer_url
    end
  end

  def self.find_url(customer)
    customer_url = nil
    begin
      zone = Zone.where(county: customer[0].county, state: customer[0].state)
      if !zone.empty?
         if !zone[0].customer_id.nil?
          custid = zone[0].customer_id
          @cus_check = Customer.find(custid)
          Zipcode.covert_demo if @cus_check.status_id == 2
          customer_url = zone[0].customer if @cus_check.status_id != 3
         end
       end
      rescue StandardError => e
        puts "********************** rescue error"
        puts e.message
        puts e.backtrace.inspect
     end
  end

  def self.write_device(device, custid)
   db = Device.new
   db.customer_id = custid
   db.browser = device.name

   db.ipad  = device.device.ipad?
   db.iphone = device.device.iphone?
   db.mobile = device.device.mobile?
   db.surface = device.device.surface?
   db.tablet = device.device.tablet?
   db.platform_name = device.platform.name
   db.platform_version = device.platform.version
   db.android = device.platform.android?(4.2)
   db.platform_ios = device.platform.ios?
   db.linux = device.platform.linux?
   db.mac_platform = device.platform.mac?
   db.other_platform = device.platform.other?
   db.windows_platform = device.platform.windows?
   db.windows_mobile = device.platform.windows_mobile?
   db.windows_phone = device.platform.windows_phone?
   db.save
  end

  def self.covert_demo
    #Time expire change to status
    if @cus_check.created_at + 30.days < Time.now
       @cus_check.status_id = 3
       @cus_check.save(:validate => false)
    end
  end

  def zipcode_name
   @zipcode.try(:city)
  end

#TODO REFACTOR this code
  def self.validate_input(city, zipcode)
    if zipcode.size != 0
       ccheck = Zipcode.where(zip_code: zipcode.to_i)
       if !ccheck.empty?
         ccheck = Zipcode.geturl(ccheck[0])
         ccheck = 'https://lease.cosmeticsurgery.com/' if ccheck.nil?
       else
         ccheck = nil
       end
    end

    if zipcode.size == 0
      if !city.split(",")[1].nil?
        ccheck = Zipcode.where(city: city.split(",")[0].strip.titleize,
          state: city.split(",")[1].upcase.strip)
          if !ccheck.empty?
             ccheck = Zipcode.geturl(ccheck[0])
             ccheck = 'https://lease.cosmeticsurgery.com/' if ccheck.nil?
          else
            ccheck = nil
          end
      else
        ccheck = nil
      end
    end
    return ccheck
  end


  def zipcode_name=(name)
   self.zipcode = Zipcode.find_by(city: name) if name.present?
  end


  def self.geturl(url)
    ccheck = url.zip_code.to_i
    ccheck = find_customer_url(ccheck)
    if !ccheck.nil?
     ccheck = ccheck.customer_url
    else
      ccheck = nil
    end
  end
end
