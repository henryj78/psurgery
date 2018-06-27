class CreateSales < ActiveRecord::Migration[5.2]
  def change
    create_table :sales do |t|
      t.string :full_name
      t.string :first_name
      t.string :last_name
      t.string :territory
      t.integer :customer_id

      t.timestamps
    end
  end
end
