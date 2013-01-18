class EdmTemplate < ActiveRecord::Base
  has_and_belongs_to_many :pictures

  attr_accessible :editingfile, :locked, :name, :preview, :content
end
