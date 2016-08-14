require 'rails_helper'

RSpec.describe PostgreSQL::TablesController, type: :controller do

  describe 'GET index' do
    context 'inexistent database' do
      before { get :index, account_slug: 'nice-co', deployment_id: 1234, database_name: 'hello' }
      it { expect(response.status).to eq(404) }
      it { expect(response).to render_template("errors/not_found") }

      describe 'display error message' do
        render_views
        it { expect(response.body).to match /Database not found\./ }
        it { expect(response).to render_template("megatron/errors") }
      end
    end
  end

end
