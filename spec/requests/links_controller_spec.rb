require 'rails_helper'

RSpec.describe LinksController, type: :controller do
  it "shows the previous links used before" do
    get :index
    expect(response.content_type).to eq "application/json"
  end
end
