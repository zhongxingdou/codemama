class EdmTemplate < ActiveRecord::Base
  has_and_belongs_to_many :pictures
  default_scope order('created_at DESC')

  attr_accessible :editingfile, :locked, :name, :preview, :content
end
