class CreateCages < ActiveRecord::Migration
  def change
    create_table :cages do |t|
      t.float   :size
      t.string  :category
      t.string  :name
      t.boolean :lights_on
    end
  end
end
