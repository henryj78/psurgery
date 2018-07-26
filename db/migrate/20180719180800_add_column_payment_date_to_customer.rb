class AddColumnPaymentDateToCustomer < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :payment_date, :string
  end
end
