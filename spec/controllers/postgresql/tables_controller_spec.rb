require 'rails_helper'

RSpec.describe PostgreSQL::TablesController, type: :controller do

  describe 'GET index' do
    context 'inexistent database' do
      before { get :index, account_slug: 'nice-co', deployment_id: 1234, database_name: 'hello' }
      include_examples "raise Errors::NotFound", "Database not found."
    end
  end

end
