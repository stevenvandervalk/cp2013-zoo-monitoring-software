class Door < ActiveRecord::Base
  attr_accessible :entrance_id, :open, :locked

  belongs_to :entrance
end
