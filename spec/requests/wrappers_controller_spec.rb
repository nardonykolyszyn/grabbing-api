require 'rails_helper'

RSpec.describe WrappersController, :type => :controller do

  it "grabbing an url and store tags into the database" do
    post :create, params: { page: 'http://nardonykolyszyn.com.ve' }
    expect(response).to have_http_status(200)
  end

end
