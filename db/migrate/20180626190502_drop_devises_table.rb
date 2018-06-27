class DropDevisesTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :devises
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
