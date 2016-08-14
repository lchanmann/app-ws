require 'rails_helper'

RSpec.describe PostgreSQL::DatabasesController, type: :controller do

  describe 'GET index' do
    context 'inexistent deployment' do
      before { get :index, account_slug: 'nice-co', deployment_id: 12345 }
      include_examples "raise Errors::NotFound", "Deployment not found"
    end
  end

end
