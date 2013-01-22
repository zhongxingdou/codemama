# encoding: utf-8
class PicturesController < InheritedResources::Base
  before_filter :authenticate_user!, :set_name

  #图片存储的根文件夹，图片会存储在此文件夹下的子文件夹中
  SaveRoot = Rails.root.to_s + "/public/imgs"

  #一个目录最多存放多少个图片，2指. ..
  MaximumImages = 10000 + 2

  #可接受的文件类型
  AcceptImageTypes = [".jpg",".png",".gif"]

  def set_name
    @app = "图片上传"
  end

  def index
    @pics = current_user.pictures.paginate(:page => params[:page], :per_page => 10).order("created_at DESC")
  end


  def create
    param_img = params[:image]
    unless param_img.blank?
      file = param_img[:file]

      extname = File.extname(file.original_filename)
      #只接受指定文件类型
      unless AcceptImageTypes.include? extname.downcase
        flash[:error] = "只允许上传扩展名为 #{AcceptImageTypes.to_s}的图片"
        render :index
      else
        subdir = get_save_subdir()

        save_name = make_file_name(subdir, extname)

        save_pic(file, SaveRoot + "/" + subdir, save_name)

        #存储图片的相关信息
        create_pic_info(save_name)

        redirect_to(pictures_url, :notice => '成功上传')
      end
    else
      flash[:error] = "请选择要上传的图片！"
      render :index
    end
  end

  def uploadBase64
    base_64_encoded_data = params[:image]
    # base_64_encoded_data.delete!("data:image/jpeg;base64,")
    data  = Base64.decode64(base_64_encoded_data)
    extname = ".jpg"
    subdir = get_save_subdir()
    save_name = make_file_name(subdir, extname)
    File.open(SaveRoot + "/" + subdir + "/" + save_name, 'wb') do|f|
      f.write(data)
    end
    create_pic_info(save_name)
    render :text => "/#{subdir}/#{save_name}"
  end

  def upload
    file = params[:file]

    extname = File.extname(file.original_filename)

    #只接受指定文件类型
    unless AcceptImageTypes.include? extname.downcase
      respond_to do |format|
        format.json { render :json, {:error => "只允许上传扩展名为 #{AcceptImageTypes.to_s}的图片"} }
      end
    else
      subdir = get_save_subdir()

      save_name = make_file_name(subdir, extname)

      save_pic(file, SaveRoot + "/" + subdir, save_name)

      #存储图片的相关信息
      create_pic_info(save_name)

      respond_to do |format|
        format.json  { render :json => {:filelink => "/imgs/#{subdir}/#{save_name}"} }
      end
    end
  end

  private 
    def make_file_name(subdir, extname)
      conn_char = "_"
      return subdir + conn_char + SecureRandom.hex(3) + extname
    end

    def save_pic file, save_dir, save_name
      File.open(save_dir + "/" + save_name, 'wb'){ |f| f.write(file.read)}
    end

    def create_pic_info file_name
      pic = Picture.new
      pic.user = current_user
      pic.name = file_name
      pic.save
    end

    def get_save_subdir
        #子文件夹的数量，据此推算子文件夹名
        sub_count = Dir.entries(SaveRoot).grep(/^\d+$/).size


        #准备要存储到的文件夹
        # if(File.exists?(SaveRoot + "/.DS_Store")) #for mac os
          # sub_count = sub_count - 1
        # end

        logger.debug "sub_count:" + sub_count.to_s
        
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
        return last_num.to_s
    end
end
