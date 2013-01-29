class Cage < ActiveRecord::Base
  attr_accessible :description, :name, :size, :category, :longitude, :latitude,
    :date_last_fed, :date_last_cleaned, :lights_on

  validates :name, :presence => true
  validates :name, :length => { :minimum => 1 }
  validates :size, :numericality => { :greater_than_or_equal_to => 5 }
  validates :longitude, :numericality => { :greater_than_or_equal_to => -180, :less_than_or_equal_to => 180 }
  validates :latitude,  :numericality => { :greater_than_or_equal_to => -90, :less_than_or_equal_to => 90 }

  has_many :entrances, :dependent => :destroy
  has_many :employees
  has_many :animals
end
