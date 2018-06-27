class CreateZipcodes < ActiveRecord::Migration[5.2]
  def change
    create_table :zipcodes do |t|
      t.string :zip_code
      t.string :latitude
      t.string :longitutde
      t.string :county
      t.string :country
      t.string :state
      t.string :city
      t.string :zipcode_type

      t.timestamps
    end
  end
end
