class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :cell_number
      t.string :office_number
      t.string :description
      t.string :customer_url
      t.string :boardcertified
      t.integer :status_id
      t.integer :zone_id
      t.integer :state_id
      t.integer :sale_id
      t.integer :validate_cus
      t.string :deactivate

      t.timestamps
    end
  end
end
