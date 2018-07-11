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
    begin
     zone = Zone.where(county: customer[0].county, state: customer[0].state)
     if !zone.empty?
      custid = zone[0].customer_id
      @cus_check = Customer.find(custid)
      Zipcode.covert_demo if @cus_check.status_id == 2
      customer_url = zone[0].customer if @cus_check.status_id != 3
     end
   rescue
   end
  end

  def self.write_device(device, custid)
   db = Device.new
   db.customer_id = custid
   db.browser = device.name
   db.save
  end

  def self.covert_demo
    #Time expire change to status
    if @cus_check.created_at + 30.days < Time.now
       @cus_check.status_id = 3
       @cus_check.save(:validate => false)
    end
  end
end
