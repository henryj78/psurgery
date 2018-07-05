class Customer < ApplicationRecord
 has_many :zones
 has_many :devices

  # TODO Testing Development enviroment - customer
   establish_connection :external_database

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
   db[0].customer_id = customer[:customer_id].to_i
   db[0].save(:validate => false)
 end

 def self.write_track_record(customer)
   track_db = Track.new
   track_db.user_id = customer.id
   track_db.name = customer.email
   track_db.screen = "Customer Validation"
   track_db.command = "Validated Customer"
   track_db.save
 end

 def self.write_customer_validation(customer)
  cust = Customer.find(customer[:customer_id].to_i)
  cust.validate_cus = 1
  cust.save(:validate => false)
 end

 def self.deativate_customer(customer)
   db = Customer.find(customer[:customer_id].to_i)
   db.deactivate = customer[:customer][:deactivate]
   db.validate_cus = nil
   db.save(:validate => false)
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
end
