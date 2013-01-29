class Employee < ActiveRecord::Base
  attr_accessible :cage_id, :employee_id, :name
  belongs_to :cage
  has_many :messages, :dependent => :destroy
end
