class Picture < ActiveRecord::Base
  attr_accessible :name

  validates :user_id, presence: true

  belongs_to :user

  before_destroy :rm_pic


  SaveRoot = "public/imgs"

  def rm_pic
    name = self.name
    subdir = name[0...name.index("_")]
    fullname = SaveRoot + "/" + subdir + "/" + name
    if File.exists? fullname
      FileUtils.rm(fullname)
    end
  end
end
