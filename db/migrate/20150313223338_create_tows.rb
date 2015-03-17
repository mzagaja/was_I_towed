class CreateTows < ActiveRecord::Migration
  def change
    create_table :tows do |t|
      t.integer :TowNum
      t.string :Tow_Firm
      t.string :Tow_Firm_Address
      t.string :Tow_Firm_Phone
      t.string :Vehicle_State
      t.string :Vehicle_Year
      t.string :Make
      t.string :Model
      t.string :Color
      t.string :Tow_From_Address
      t.date :Date
      t.time :Time
      t.string :geom

      t.timestamps null: false
    end
  end
end
