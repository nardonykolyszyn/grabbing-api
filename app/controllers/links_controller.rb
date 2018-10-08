class LinksController < ApplicationController
  def index
    @links = Wrapper.pluck(:id, :url)
    if @links.any?
      render json: @links, status: 200
    else
      render json: { error: 'There are not any link provided yet' }
    end
  end
end
