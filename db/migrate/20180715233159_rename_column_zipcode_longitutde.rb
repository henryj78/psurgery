class RenameColumnZipcodeLongitutde < ActiveRecord::Migration[5.2]
  def change
    rename_column :zipcodes, :longitutde, :longitude
  end
end
