class ImagesController < InheritedResources::Base
  before_filter :authenticate_user!

  def create
    create! { collection_path }
  end

  protected

  def begin_of_association_chain
    current_user
  end
end
