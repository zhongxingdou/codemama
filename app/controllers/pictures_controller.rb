class PicturesController < InheritedResources::Base
  before_filter :authenticate_user!

  #图片存储的根文件夹，图片会存储在此文件夹下的子文件夹中
  SaveRoot = "public/imgs"

  #一个目录最多存放多少个图片，2指. ..
  MaximumImages = 10000 + 2

  #可接受的文件类型
  AcceptImageTypes = [".jpg",".png",".gif"]

  def create
    param_img = params[:image]
    unless param_img.blank?
      file = param_img[:file]

      extname = File.extname(file.original_filename)
      #只接受指定文件类型
      unless AcceptImageTypes.include? extname.downcase
        flash[:error] = "Accepted file extention is #{AcceptImageTypes.to_s}"
        render :index
      else
        #子文件夹的数量，据此推算子文件夹名
        sub_count = Dir.entries(SaveRoot).size - 2 #-2 排除 . ..


        #准备要存储到的文件夹
        if(File.exists?(SaveRoot + "/.DS_Store")) #for mac os
          sub_count = sub_count - 1
        end

        if sub_count == 0
          save_dir = SaveRoot + "/0"

          FileUtils.mkdir_p(save_dir) 
          last_num = 0
        else
          last_num = sub_count - 1

          save_dir = SaveRoot + "/" + last_num.to_s


          imgs_count = Dir.entries(save_dir).size
          if(File.exists?(save_dir + "/.DS_Store")) #for mac os
            imgs_count = imgs_count - 1
          end


          if imgs_count+1 > MaximumImages
            last_num = last_num + 1
            save_dir = SaveRoot + "/" + last_num.to_s
            FileUtils.mkdir_p(save_dir) 
          end
        end

        #保存文件
        conn_char = "_"
        file_name = last_num.to_s + conn_char + SecureRandom.hex(8) + File.extname(file.original_filename)
        File.open(save_dir + "/" + file_name, 'wb'){ |f| f.write(file.read)}

        #存储图片的相关信息
        pic = Picture.new
        pic.user = current_user
        pic.name = file_name
        pic.save

        redirect_to(pictures_url, :notice => 'upload success')
      end
    else
      flash[:error] = "Please select a file to upload!"
      render :index
    end
  end

end
