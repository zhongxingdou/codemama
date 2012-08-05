class Image < ActiveRecord::Base
  attr_accessible :data

  mount_uploader :data, ImageUploader

  validates :user_id, presence: true

  belongs_to :user, counter_cache: true

  default_scope order('created_at DESC')
end
# == Schema Information
#
# Table name: images
#
#  id         :integer(4)      not null, primary key
#  data       :string(255)
#  user_id    :integer(4)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

