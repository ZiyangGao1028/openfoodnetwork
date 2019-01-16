require 'rails_helper'

RSpec.describe "api/v1s/index", :type => :view do
  before(:each) do
    assign(:api_v1_pets, [
      Api::V1::Pet.create!(),
      Api::V1::Pet.create!()
    ])
  end

  it "renders a list of api/v1s" do
    render
  end
end
