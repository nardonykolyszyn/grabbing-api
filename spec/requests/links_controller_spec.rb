require 'rails_helper'

RSpec.describe LinksController, type: :controller do
  it "shows the previous links used before" do
    get :index
    expect(response).to have_http_status(200)
  end
end
