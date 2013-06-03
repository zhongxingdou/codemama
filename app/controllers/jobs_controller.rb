class JobsController < InheritedResources::Base
  # before_filter :authenticate_user!, :set_name

  def index
    @jobs = Job.all(:order => "id DESC")
    respond_to do |format|
      if params[:callback]
        format.js  { render  :json => @jobs.to_json, :callback => params[:callback] }
      else
        format.json  { render  :json => @jobs.to_json }
      end
    end
  end

end
