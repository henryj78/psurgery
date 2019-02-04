class Customer < ApplicationRecord
 validates :first_name, :last_name, :zip, :customer_url,  :presence => true

 has_many :zones
 has_many :devices

  # TODO Testing Development enviroment - customer
  # establish_connection :external_database

def self.write_customer_to_zone (customer)
  db = Zone.find(customer.zone_id)
  db.customer_id = customer.id
  db.save
 end

 def self.write_sales_person(customer)
   db = Sale.find(customer.sale_id)
   sdb = Sale.new
   sdb.first_name =  db.first_name
   sdb.last_name =   db.last_name
   sdb.territory =   db.territory
   sdb.customer_id = db.id
   sdb.full_name =   db.full_name
   sdb.save
 end

 def self.retrieve_zone_id(customer)
   db  = Zipcode.where(zip_code: customer.zip.to_i)
   if !db.empty?
    dbr = Zone.where(county: db[0].county , state: db[0].state)
    if !dbr.empty?
      customer.zone_id = dbr[0].id
      Customer.write_new_zone(customer)
    end
   end
 end

 def self.write_new_zone(customer)
   db = Zone.new
   cdb =  Zipcode.where(zip_code: customer.zip)
   db.county = cdb[0].county
   db.state =  cdb[0].state
   db.save(:validate => false)
   return db.id
 end

 def self.write_addtional_zone(customer)
   county = County.find(customer[:customer][:zone_id].to_i)
   state  = State.find(customer[:customer][:state_id].to_i)
   db = Zone.where(county: county.name, state: state.name)

   # Check is zone is being useed
   if db[0].customer_id.nil?
    db[0].customer_id = customer[:customer_id].to_i
    db[0].save(:validate => false)

    cus = customer[:customer_id].to_i
   else
     cus = 0
   end
   return cus
 end

 def self.write_track_record(customer, screen, command, customer_name)
   track_db = Track.new
   track_db.user_id = customer.id
   track_db.name = customer.email
   track_db.screen = screen
   track_db.command = command
   track_db.customer_name = customer_name.first_name + " " + customer_name.last_name
   track_db.save
 end

 def self.write_customer_validation(customer)
  cust = Customer.find(customer[:customer_id].to_i)
  cust.validate_cus = 1
  cust.status_id = 1 if cust.status_id == 3
  cust.save(:validate => false)
 end

 def self.deativate_customer(customer)
   db = Customer.find(customer[:customer_id].to_i)
   db.deactivate = customer[:customer][:deactivate]
   db.validate_cus = nil
   db.save(:validate => false)
 end

 def self.hold_customer(customer)
   customer.validate_cus = nil
   customer.save(:validate => false)
 end

 def self.remove_customer_zone(customer)
   customerid = customer[:customer_id].to_i
   county = Zone.where(customer_id: customerid)
   county.each do |i|
     if customerid == i.customer_id
        i.customer_id = nil
        i.save(:validate => false)
     end
   end
 end

 def self.removecusid(zone)
   zoneid = zone[:customer_id].to_i
   change_zone = Zone.find(zoneid)
   change_zone.customer_id = nil
   change_zone.save(:validate => false)
 end

 def self.payment_inspect(customer)
   customer.each do |cus|
     db = Customer.find(cus.id)
     payvalue = Payment.where(custid: db.id)
     db.payment_color = 0 if payvalue.empty?
     db.payment_color = payment_color_choice(payvalue) if !payvalue.empty?
     db.county_count = 0 if cus.zones.empty?
     db.county_count = 1 if !cus.zones.empty?
     db.save(:validate => false)
   end
 end


 def self.payment_color_choice(customer)
  month = ((customer[0].created_at - Time.now)/1.day.second).to_i
  p_color = 0 # no input
  p_color = 1 if !customer[0].created_at.nil?
  p_color = 2 if month.to_i <= -30 # 30 Days
  p_color = 3 if month.to_i <= -60 # 60 Days
  return p_color
 end

 def self.remove_zone(customer)
   db = Zone.where(customer_id: customer.id)
   if !db.empty?
     db.each do |rz|
       rz.customer_id = nil
       rz.save(:validate => false)
     end
   end
 end

 def self.report_calu(customer)
   #TODO need to be refactored quick and easy
    customer_count =
      Device.where("created_at >= ? AND customer_id = ?", Time.now - 31.days, customer.id).count
    tablet_count =
      Device.where("created_at >= ? AND customer_id = ? And tablet = ?", Time.now - 31.days, customer.id, 't').count
    iphone_count =
      Device.where("created_at >= ? AND customer_id = ? And iphone = ?", Time.now - 31.days, customer.id, 't').count

    customer_array = []
    days  = (Time.now.to_date - customer.created_at.to_date).to_i
    created_date = customer.created_at.to_s
    customer_array << days
    customer_array << created_date
    customer_array << customer_count
    customer_array << customer_count #3
    customer_array << tablet_count #4
    customer_array << iphone_count #5
    customer_array << iphone_count  + tablet_count #6
    customer_array << customer_count - iphone_count #7
    customer_array << customer_count - iphone_count #8
   return customer_array
 end

 def self.report_calu60(customer)
   #TODO need to be refactored quick and easy
    customer_count =
      Device.where("created_at >= ? AND customer_id = ?", Time.now - 61.days, customer.id).count
    tablet_count =
      Device.where("created_at >= ? AND customer_id = ? And tablet = ?", Time.now - 61.days, customer.id, 't').count
    iphone_count =
      Device.where("created_at >= ? AND customer_id = ? And iphone = ?", Time.now - 61.days, customer.id, 't').count

    customer_array = []
    days  = (Time.now.to_date - customer.created_at.to_date).to_i
    created_date = customer.created_at.to_s
    customer_array << days
    customer_array << created_date
    customer_array << customer_count
    customer_array << customer_count #3
    customer_array << tablet_count #4
    customer_array << iphone_count #5
    customer_array << iphone_count  + tablet_count #6
    customer_array << customer_count - iphone_count #7
    customer_array << customer_count - iphone_count #8
   return customer_array
 end

 def self.report_calu_all(customer)
   #TODO need to be refactored quick and easy
    customer_count =
      Device.where("customer_id = ?",  customer.id).count
    tablet_count =
      Device.where("customer_id = ? And tablet = ?", customer.id, 't').count
    iphone_count =
      Device.where("customer_id = ? And iphone = ?", customer.id, 't').count

    customer_array = []
    days  = (Time.now.to_date - customer.created_at.to_date).to_i
    created_date = customer.created_at.to_s
    customer_array << days
    customer_array << created_date
    customer_array << customer_count
    customer_array << customer_count #3
    customer_array << tablet_count #4
    customer_array << iphone_count #5
    customer_array << iphone_count  + tablet_count #6
    customer_array << customer_count - iphone_count #7
    customer_array << customer_count - iphone_count #8
   return customer_array
 end
end
