class CreateEntrances < ActiveRecord::Migration
  def change
    create_table :entrances do |t|
      t.integer :cage_id

    end
  end
end
