class Entrance < ActiveRecord::Base
  attr_accessible :cage_id

  belongs_to :cage
  has_many :doors, :dependent => :destroy

  # Is the entrance open
  def open?
    open = false

    # if any door is open, consider the entrance open
    self.doors.each do |door|
      if door.open?
        open = true
      end
    end

    open
  end
end
