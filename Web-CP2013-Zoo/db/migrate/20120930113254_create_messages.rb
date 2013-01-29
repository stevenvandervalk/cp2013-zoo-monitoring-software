class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :employee_id
      t.text :message

    end
  end
end
