class CreateSalePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :sale_payments do |t|
      t.integer :sale_id
      t.string :payment_amount
      t.string :description

      t.timestamps
    end
  end
end
