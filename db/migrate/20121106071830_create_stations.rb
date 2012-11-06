class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
		t.string :code 
    	t.string :lat  
    	t.string :lon
    	t.string :line_1
    	t.string :line_2
    	t.string :line_3
    	t.string :line_4
    	t.string :name 
    	t.string :station_together1
    	t.string :station_together2 
      t.timestamps
    end
  end
end
