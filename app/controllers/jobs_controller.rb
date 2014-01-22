class JobsController < InheritedResources::Base
  # before_filter :authenticate_user!, :set_name

  def index
    @jobs = Job.select("id, position, location, created_at, expired_date").where("expired_date > ?", Time.now).paginate(:page => params[:page], :per_page => 10).order("id DESC")

    @count = @jobs.length
    result = {
      :jobs => @jobs,
      :count => @count,
      :page_index => params[:page] || 1,
      :page_size => 10
    }
    respond_to do |format|
      if params[:callback]
        format.js  { render  :json => result.to_json, :callback => params[:callback] }
      else
        format.json  { render  :json => @jobs.to_json }
      end
    end
  end


  def show
    @job = Job.find(params[:id])
    respond_to do |format|
      if params[:callback]
        format.js  { render  :json => @job, :callback => params[:callback] }
      else
        format.json  { render  :json => @job.to_json }
      end
    end
  end

end
