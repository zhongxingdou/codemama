class EdmsController < InheritedResources::Base
  before_filter :authenticate_user!, :set_name
  def set_name
    @app = "EDM"
  end

  def index
    @edms = Edm.paginate(:page => params[:page], :per_page => 10)
  end

  def new
    tmpl_id = params[:edm_template_id]
    @template = EdmTemplate.find(tmpl_id) if tmpl_id
    @edm = Edm.new
    @edm.content = @template.content if @template
  end

  def create
    @edm = Edm.new(params[:edm])
    tmpl_id = params[:edm_template_id]
    template = EdmTemplate.find(tmpl_id) if tmpl_id
    @edm.template = template if template
    @edm.owner = current_user
    @edm.content = template.content if template
    respond_to do |format|
      if @edm.save
        flash[:notice] = 'Edm was successfully created.'
        format.html  { redirect_to(:action => :index)}
        format.json  { render :json => @edm,
        :status => :created, :location => @edm }
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @edm.errors,
        :status => :unprocessable_entity }
      end
    end
  end

  def update
    @edm = Edm.find(params[:id])

    respond_to do |format|
      if @edm.update_attributes(params[:edm])
        flash[:notice] = 'Edm was successfully updated.'
        format.html  { redirect_to(:action => :index)}
        # format.json  { render :json => @edm, :status => :updated, :location => @edm }
        # format.json { head :no_content}
        format.json { render :json => {:status => "success"} }
        # format.json { render :json => params[:edm]}
      else
        format.html  { render :action => "edit" }
        format.json  { render :json => @edm.errors,
        :status => :unprocessable_entity }
      end
    end
  end

  def clone
    clone = Edm.find(params[:id])
    @edm = Edm.new
    @edm.content = clone.content
    @edm.template = clone.template
    render :new
  end

  def download
    show_gbk
    send_data @content, :type => 'application/xhtml', :filename => "#{@name}.html"
  end

  def preview
    show_gbk
    render :preview, :layout => false
  end

  def edit_content
    @edm = Edm.find(params[:id])
    render :edit_content, :layout => false
  end

  private
  def show_gbk
    require 'iconv'
    edm = Edm.find(params[:id])
    response.headers["Content-Type"] = "text/html; charset=gb2312"
    @content = Iconv.conv("gb2312", "utf-8", edm.content)
    @name = Iconv.conv("gb2312", "utf-8", edm.name)
  end

end
