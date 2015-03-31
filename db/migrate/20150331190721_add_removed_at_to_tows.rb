class AddRemovedAtToTows < ActiveRecord::Migration
  def change
    add_column :tows, :removed_at, :datetime
  end
end
