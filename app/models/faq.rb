class Faq < ActiveRecord::Base
  validates :user_id, presence: true

  belongs_to :user

  attr_accessible :answer, :question, :title

  default_scope order('created_at DESC')
end
