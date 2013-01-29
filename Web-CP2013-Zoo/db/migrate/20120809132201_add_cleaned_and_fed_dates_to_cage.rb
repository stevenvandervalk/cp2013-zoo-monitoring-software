class AddCleanedAndFedDatesToCage < ActiveRecord::Migration
  def change
    add_column :cages, :date_last_fed,     :datetime
    add_column :cages, :date_last_cleaned, :datetime
  end
end
