class AddColumnRoleIdToCustomer < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :role_id, :integer
  end
end
