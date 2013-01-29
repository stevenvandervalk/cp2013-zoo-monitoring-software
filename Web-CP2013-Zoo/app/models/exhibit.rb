class Exhibit < ActiveRecord::Base
  attr_accessible :description

  has_many :cages, :dependent => :destroy
end
