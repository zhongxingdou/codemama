class EmployeesController < InheritedResources::Base
  # before_filter :authenticate_user!, :set_name

  def index
    condition = {}
    unless params[:department].empty?
      condition[:department] = params[:department]
    end
    @employees = Employee.where(condition).order("id DESC")
    respond_to do |format|
      if params[:callback]
        format.js  { render  :json => @employees.to_json, :callback => params[:callback] }
      else
        format.json  { render  :json => @employees.to_json }
      end
    end
  end
end
