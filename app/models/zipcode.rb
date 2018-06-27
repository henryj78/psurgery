class Zipcode < ApplicationRecord
  # TODO Find Customer url from zip code
  # TODO Testing Development enviroment - zipcode
  establish_connection :external_database


  def self.find_customer_url(search)
    county = Zipcode.where(zip_code: search)
    customer_url = Zipcode.find_url(county)
    return customer_url
  end

  def self.find_url(customer)
    customer_url = nil
    zone = Zone.where(county: customer[0].county, state: customer[0].state)
    customer_url = zone[0].customer if !zone.empty?
  end

  def self.write_device(device, custid)
   db = Device.new
   db.customer_id = custid
   db.browser = device.name
   db.save
  end
end
