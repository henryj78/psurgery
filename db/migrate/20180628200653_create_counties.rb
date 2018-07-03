class CreateCounties < ActiveRecord::Migration[5.2]
  def change
    create_table :counties do |t|
      t.string :name
      t.integer :state_id

      t.timestamps
    end
  end
end
