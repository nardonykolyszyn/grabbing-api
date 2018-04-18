class LinksController < ApplicationController
  def index
  	@links = Wrapper.pluck(:id, :url)
  	render json: @links
  end
end