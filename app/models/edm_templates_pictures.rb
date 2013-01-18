class EdmTemplatesPictures < ActiveRecord::Base
  belongs_to :edm_template
  belongs_to :picture
  # attr_accessible :title, :body
end
