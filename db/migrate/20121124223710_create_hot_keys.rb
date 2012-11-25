class CreateHotKeys < ActiveRecord::Migration
  def change
    create_table :hot_keys do |t|
      t.string :phone_number
      t.string :input
      t.integer :station_id

      t.timestamps
    end
  end
end
