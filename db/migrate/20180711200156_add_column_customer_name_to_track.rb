class AddColumnCustomerNameToTrack < ActiveRecord::Migration[5.2]
  def change
    add_column :tracks, :customer_name, :string
  end
end
