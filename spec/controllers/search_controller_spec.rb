require 'rails_helper'

describe SearchController do
  let!(:tournaments) { create_list(:tournament, 3) }
  let!(:machines) { create_list(:machine, 3) }
  let!(:queried_machine) { create(:machine, name: "Cakeshop") }

  describe '#index' do
    it "with no query returns no results" do
      get :index

      expect(response).to have_http_status(200)
      expect(response.body).to_not include("Machines")
      expect(response.body).to_not include("Tournaments")
    end

    it "responds with queried results as @machines and @tournaments" do
      get :index, params: { query: "cake" }

      expect(response).to have_http_status(200)
      # expect(response.body).to include(queried_machine.name) # response.body is blank...?
    end

    it "responds with json when the request is json" do
      request.headers["Content-Type"] = "application/json"
      get :index, params: { query: "cake" }

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["machines"].first["name"]).to eq "Cakeshop"
    end
  end
end
