class Job < ActiveRecord::Base
  attr_accessible :description, :expired_date, :location, :position, :requirements
end
