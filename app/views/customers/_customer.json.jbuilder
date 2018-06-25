json.extract! customer, :id, :first_name, :last_name, :address, :city, :state, :zip, :cell_number, :office_number, :description, :customer_url, :boardcertified, :status_id, :zone_id, :state_id, :sale_id, :validate_cus, :deactivate, :created_at, :updated_at
json.url customer_url(customer, format: :json)
