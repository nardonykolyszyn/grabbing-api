class WrappersController < JSONAPI::ResourceController
  def create
  	if params[:page].present?
  	  @wrapper = GrabbingService.new(params).perform
  	  render json: @wrapper, status: 200
  	else
  	  render plain: 'Please provide at least one page'
  	end
  end
end
