require 'rails_helper'

RSpec.describe PostgreSQL::TablesController, type: :controller do

  describe 'GET index' do
    context 'inexistent database', stub_api: true do
      before { get :index, account_slug: 'nice-co', deployment_id: $deployment_id, database_name: 'hello' }
      include_examples "raise Errors::NotFound", "Database not found."
    end
  end

end
