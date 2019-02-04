class CreateDoors < ActiveRecord::Migration[5.2]
  def change
    create_table :doors do |t|
      t.string :latitude
      t.string :longitutde

      t.timestamps
    end
  end
end
