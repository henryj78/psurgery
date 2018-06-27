class CreateDevises < ActiveRecord::Migration[5.2]
  def change
    create_table :devises do |t|
      t.integer :customer_id
      t.string :ip_address
      t.string :zipcode
      t.string :os
      t.string :model
      t.string :browser

      t.timestamps
    end
  end
end
