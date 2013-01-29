class Animal < ActiveRecord::Base
  attr_accessible :cage_id, :animal_id, :name
  belongs_to :cage
end
