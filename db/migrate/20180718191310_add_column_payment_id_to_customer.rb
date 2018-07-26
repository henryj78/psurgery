class AddColumnPaymentIdToCustomer < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :payment_id, :integer
    add_column :customers, :payment_color, :integer
  end
end
