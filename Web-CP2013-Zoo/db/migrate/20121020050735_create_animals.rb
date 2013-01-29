class CreateAnimals < ActiveRecord::Migration
  def change
    create_table :animals do |t|
      t.string :animal_id
      t.string :name
      t.integer :cage_id
    end
  end
end
