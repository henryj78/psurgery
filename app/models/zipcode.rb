class Zipcode < ApplicationRecord
  # TODO Find Customer url from zip code
  # TODO Testing Development enviroment - zipcode
  # establish_connection :external_database


  def self.find_customer_url(search)
    county = Zipcode.where(zip_code: search)
    customer_url = Zipcode.find_url(county)
    return customer_url
  end

  #TODO make this more dry combine methods
  def self.find_customer_url_city(city)
    customer_url = 'https://lease.cosmeticsurgery.com/'
    county = Zipcode.where(city: city)

    if !county.empty?
      zone = Zone.where(county: county[0].county)
      if !zone.empty?
        custid = zone[0].customer_id
        @cus_check = Customer.find(custid)
        Zipcode.covert_demo if @cus_check.status_id == 2
        customer_url = zone[0].customer if @cus_check.status_id != 3
      end
      return customer_url
    end
  end

  def self.find_url(customer)
    customer_url = nil
    begin
      zone = Zone.where(county: customer[0].county, state: customer[0].state)
      if !zone.empty?
       custid = zone[0].customer_id
       @cus_check = Customer.find(custid)
       Zipcode.covert_demo if @cus_check.status_id == 2
       customer_url = zone[0].customer if @cus_check.status_id != 3
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

  def zipcode_name=(name)
   self.zipcode = Zipcode.find_by(city: name) if name.present?
  end
end
