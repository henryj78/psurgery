class AddColumnCountyCountToCustomer < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :county_count, :string
  end
end
