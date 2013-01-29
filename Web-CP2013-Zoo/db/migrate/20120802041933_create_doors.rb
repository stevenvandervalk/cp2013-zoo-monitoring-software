class CreateDoors < ActiveRecord::Migration
  def change
    create_table :doors do |t|
      t.boolean :open
      t.boolean :locked
      t.integer :entrance_id

    end
  end
end
