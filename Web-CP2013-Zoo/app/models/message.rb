class Message < ActiveRecord::Base
  attr_accessible :employee_id, :message

  belongs_to :employee
end
