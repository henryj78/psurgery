class RemoveColumnRoleIdFromCustomer < ActiveRecord::Migration[5.2]
  def change
    remove_column :customers, :role_id, :integer
  end
end
