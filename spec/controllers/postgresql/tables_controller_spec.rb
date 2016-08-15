require 'rails_helper'

RSpec.describe PostgreSQL::TablesController, type: :controller do

  describe 'GET index' do
    context 'inexistent database', stub_api: true do
      before { get :index, account_slug: 'nice-co', deployment_id: $deployment_id, database_name: 'hello' }
      include_examples "raise Errors::NotFound", "Database not found."
    end

    describe 'display link to show action', stub_api: true do
      render_views
      before { get :index, account_slug: 'nice-co', deployment_id: $deployment_id, database_name: 'booktown_test' }
      it { expect(response.body).to match /#{postgresql_database_table_path(table_name: 'tbl_1')}/ }
    end
  end

end
