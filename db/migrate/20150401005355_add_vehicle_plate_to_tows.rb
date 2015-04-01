class AddVehiclePlateToTows < ActiveRecord::Migration
  def change
    add_column :tows, :Vehicle_Plate, :string, limit: 10
    add_index :tows, :Vehicle_Plate
  end
end
