class AddLatitudeAndLongitudeToCage < ActiveRecord::Migration
  def change
    add_column :cages, :latitude,  :float
    add_column :cages, :longitude, :float
  end
end
