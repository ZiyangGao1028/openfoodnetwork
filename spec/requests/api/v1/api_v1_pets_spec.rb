require 'rails_helper'

RSpec.describe "Api::V1::Pets", :type => :request do
  describe "GET /api_v1_pets" do
    it "works! (now write some real specs)" do
      get api_v1_pets_path
      expect(response).to have_http_status(200)
    end
  end
end
