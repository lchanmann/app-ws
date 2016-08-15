require 'rails_helper'

RSpec.describe DeploymentsController do

  describe 'GET queries', stub_api: true do
    let(:deployment) { Deployment.find $deployment_id }

    it "response status eq 200" do
      get :current_queries, account_slug: 'nice-co', deployment_id: $deployment_id
      expect(response.status).to eq(200)
    end

    it "should include executed query to @queries" do
      deployment.client.exec "SELECT 1+2+3;"
      get :current_queries, account_slug: 'nice-co', deployment_id: $deployment_id
      expect(assigns(:queries)[0].query).to eq("SELECT 1+2+3;")
    end
  end

end
