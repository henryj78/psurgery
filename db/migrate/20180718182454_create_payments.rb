class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.integer :custid
      t.string :payment_amount

      t.timestamps
    end
  end
end
