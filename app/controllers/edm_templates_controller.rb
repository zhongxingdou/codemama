class EdmTemplatesController < InheritedResources::Base
  before_filter :authenticate_user!, :set_name
  def set_name
    @app = "EDM"
  end

  def preview
    @edm_template = EdmTemplate.find(params[:id])
    render :text => @edm_template.content
  end

  def create
    @edm_template = EdmTemplate.new(params[:edm_template])
    respond_to do |format|
      if @edm_template.save
        flash[:notice] = 'Edm was successfully created.'
        format.html  { redirect_to(:action => :index)}
        format.json  { render :json => @edm_template,
        :status => :created, :location => @edm_template }
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @edm_template.errors,
        :status => :unprocessable_entity }
      end
    end
  end

  def update
    @edm_template = EdmTemplate.find(params[:id])
    respond_to do |format|
      if @edm_template.update_attributes(params[:edm_template])
        flash[:notice] = 'EDM Template was successfully updated.'
        format.html  { redirect_to(:action => :index)}
        format.json { render :json => {:status => "success"} }
      else
        format.html  { render :action => "edit" }
        format.json  { render :json => @edm_template.errors,
        :status => :unprocessable_entity }
      end
    end
  end
end
