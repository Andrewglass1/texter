class AddStationToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :station_id, :integer
  end
end
