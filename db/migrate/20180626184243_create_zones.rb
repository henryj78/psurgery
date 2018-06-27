class CreateZones < ActiveRecord::Migration[5.2]
  def change
    create_table :zones do |t|
      t.string :county
      t.string :state
      t.integer :customer_id

      t.timestamps
    end
  end
end
