class CreateGreetings < ActiveRecord::Migration[5.2]
  def change
    create_table :greetings do |t|
      t.string :latitude
      t.string :longitude
      t.string :permission

      t.timestamps
    end
  end
end
