class EdmsPictures < ActiveRecord::Base
  belongs_to :edm
  belongs_to :picture
  # attr_accessible :title, :body
end
