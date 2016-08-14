require 'rails_helper'

RSpec.describe PostgreSQL::DatabasesController, type: :controller do

  describe 'GET index' do
    context 'inexistent deployment' do
      before { get :index, account_slug: 'nice-co', deployment_id: 12345 }
      it { expect(response.status).to eq(404) }
      it { expect(response).to render_template("errors/deployment_not_found") }

      describe 'display error message' do
        render_views
        it { expect(response.body).to match /Deployment not found\./ }
        it { expect(response).to render_template("megatron/errors") }
      end
    end
  end

end
