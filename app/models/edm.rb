class Edm < ActiveRecord::Base
  belongs_to :owner, :class_name => "User", :foreign_key => :owner_id
  has_and_belongs_to_many :pictures
  belongs_to :template, :class_name => "EdmTemplate", :foreign_key => :template_id

  validates :name, :owner_id, :presence => true

  attr_accessible :editing_file, :locked, :name, :content, :owner_id, :template_id
  default_scope order('created_at DESC')
end
