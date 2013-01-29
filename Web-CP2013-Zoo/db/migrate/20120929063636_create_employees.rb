class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :employee_id
      t.string :name
      t.integer :cage_id
    end
  end
end
