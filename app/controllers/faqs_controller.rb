class FaqsController < InheritedResources::Base
  before_filter :authenticate_user!, :set_name
  def set_name
    @app = "FAQ"
  end

  def create
    @faq = Faq.new(params[:faq])
    @faq.user = current_user
    respond_to do |format|
      if @faq.save
        format.html  { redirect_to(@faq,
        :notice => 'Faq was successfully created.') }
        format.json  { render :json => @faq,
        :status => :created, :location => @faq }
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @faq.errors,
        :status => :unprocessable_entity }
      end
    end
  end
end
